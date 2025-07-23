import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar_secondary.dart';
import 'package:jackpot/components/cards/buy_resume_card.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/components/logged_user_content.dart';
import 'package:jackpot/presenter/features/payment/pages/components/not_logged_user_content.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentController controller;
  late CoreController coreController;
  late Widget content;
  @override
  void initState() {
    super.initState();

    coreController = Provider.of<CoreController>(context, listen: false);
    controller = Provider.of<PaymentController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = coreController.user;

      if (user != null) {
        controller.setPaymentData(
            newEmail: user.email,
            newPhone: user.phone,
            newUserDocument: user.document,
            newUserName: user.name);
        await controller.setBillingAddress(user.address!);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Selector<PaymentController, bool>(
            selector: (
              context,
              controller,
            ) =>
                controller.isLoading,
            builder: (context, loading, child) => Container(
                decoration: const BoxDecoration(color: secondaryColor),
                child: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  if (coreController.haveUser ||
                      controller.haveQuickPurchaseUser) {
                    content = LoggedUserContent(constraints: constraints);
                  } else {
                    content = NotLoggedUserContent(constraints: constraints);
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                            maintainState: true,
                            visible: loading,
                            child: const Loading()),
                        Visibility(
                          maintainState: true,
                          visible: !loading,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                JackAppBarSecondary(
                                  child: Expanded(
                                    child: BuyResumeCard.small(
                                      couponsQuantity:
                                          controller.couponsQuantity!,
                                      totalValue: controller.totalValue!,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: content),
                                SizedBox(
                                  height: Responsive.getHeightValue(20),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  );
                })))));
  }
}
