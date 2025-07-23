import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar_secondary.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/buy_resume_card.dart';
import 'package:jackpot/components/cards/match_card_carousel.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/quick_purchase/store/quick_purchase_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/br_phone_formatter.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class QuickPurchasePage extends StatefulWidget {
  const QuickPurchasePage({super.key});

  @override
  State<QuickPurchasePage> createState() => _QuickPurchasePageState();
}

class _QuickPurchasePageState extends State<QuickPurchasePage>
    with SingleTickerProviderStateMixin {
  late QuickPurchaseController controller;
  late PaymentController paymentController;
  late CoreController coreController;
  late JackpotController jackController;
  double couponPrice = 0;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<QuickPurchaseController>(context, listen: false);
    jackController = Provider.of<JackpotController>(context, listen: false);
    paymentController = Provider.of<PaymentController>(context, listen: false);
    coreController = Provider.of<CoreController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const JackBottomNavigationBar(),
      body: Container(
        decoration: const BoxDecoration(color: secondaryColor),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                JackAppBarSecondary(
                  child: Expanded(
                    child: BuyResumeCard.small(
                      couponsQuantity: paymentController.couponsQuantity!,
                      totalValue: paymentController.totalValue!,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsive.getHeightValue(16),
                      ),
                      Selector<JackpotController, List<JackpotEntity>>(
                          selector: (context, controller) =>
                              controller.selectedJackpot!,
                          builder: (context, jackpots, child) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: Responsive.getHeightValue(16)),
                                child: MatchCardCarousel(
                                  jackpots: jackpots,
                                  constraints: constraints,
                                ),
                              )),
                      SizedBox(
                        height: Responsive.getHeightValue(16),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Text(
                      //     'Nacionalidade',
                      //     textAlign: TextAlign.left,
                      //     style:
                      //         JackFontStyle.bodyBold.copyWith(color: darkBlue),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Responsive.getHeightValue(5),
                      // ),
                      Consumer<QuickPurchaseController>(
                        builder: (context, controller, child) => Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              // JackDropdown(
                              //     height: Responsive.getHeightValue(300),
                              //     isValid: true,
                              //     onTap: (_) {},
                              //     width: Responsive.getHeightValue(300),
                              //     elements: controller.countries
                              //         .map((element) => element.name!)
                              //         .toList(),
                              //     label: 'Nacionalidade',
                              //     controller: controller.nationalityController),
                              // SizedBox(
                              //   height: Responsive.getHeightValue(20),
                              // ),
                              JackTextfield(
                                label: Text(
                                  'CPF',
                                  style: JackFontStyle.bodyBold
                                      .copyWith(color: darkBlue),
                                ),
                                controller: controller.documentController,
                                inputAction: TextInputAction.next,
                                formatter: [CpfFormatter.maskFormatter],
                                hint: 'CPF',
                                onChanged: (value) async {
                                  controller.setDocumentMask();
                                  if (value.length == 14) {
                                    await controller.checkDocument();
                                    if (controller.hasError) {
                                      ErrorDialog.show("Erro",
                                          controller.exception!, context);
                                    }
                                  }
                                },
                                inputType: TextInputType.number,
                                validator: (value) =>
                                    controller.validDocument(),
                              ),
                              SizedBox(
                                height: Responsive.getHeightValue(20),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: JackTextfield(
                                      label: Text(
                                        'E-mail',
                                        style: JackFontStyle.bodyBold
                                            .copyWith(color: darkBlue),
                                      ),
                                      controller: controller.emailController,
                                      hint: 'E-mail',
                                      inputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) async {
                                        await controller.checkEmail();
                                        if (controller.hasError) {
                                          ErrorDialog.show("Erro",
                                              controller.exception!, context);
                                        }
                                      },
                                      validator: (value) =>
                                          controller.validEmail(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              JackTextfield(
                                label: Text(
                                  'Telefone',
                                  style: JackFontStyle.bodyBold
                                      .copyWith(color: darkBlue),
                                ),
                                controller: controller.phoneController,
                                hint: 'Telefone',
                                inputType: TextInputType.datetime,
                                inputAction: TextInputAction.next,
                                validator: (value) {
                                  final handledValue = value as String;
                                  if (handledValue.length < 14) {
                                    return 'Insira um telefone válido';
                                  }
                                  return null;
                                },
                                formatter: [
                                  BrPhoneInputFormatter(),
                                ],
                              ),
                              SizedBox(
                                height: Responsive.getHeightValue(20),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 16, bottom: 16),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Responsive.getHeightValue(20),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                Responsive.getHeightValue(16)),
                                            decoration: BoxDecoration(
                                                color: secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      offset: Offset(1, 0),
                                                      blurRadius: 0.8,
                                                      spreadRadius: 0.8,
                                                      color: lightGrey),
                                                  BoxShadow(
                                                    offset: Offset(-1, 0),
                                                    blurRadius: 0.8,
                                                    spreadRadius: 0.8,
                                                    color: lightGrey,
                                                  ),
                                                  BoxShadow(
                                                      offset: Offset(0, 1),
                                                      blurRadius: 0.8,
                                                      spreadRadius: 0.8,
                                                      color: lightGrey),
                                                  BoxShadow(
                                                    offset: Offset(0, -1),
                                                    blurRadius: 0.8,
                                                    spreadRadius: 0.8,
                                                    color: lightGrey,
                                                  )
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      Responsive.getHeightValue(
                                                          20)),
                                              child: Text(
                                                  'PARA VISUALIZAR SEU CUPON É NECESSÁRIO REALIZAR O LOGIN.',
                                                  style: JackFontStyle
                                                      .bodyLargeBold
                                                      .copyWith(
                                                          color: mediumGrey)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        backgroundColor: warning,
                                        radius: Responsive.getHeightValue(22),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: Icon(Icons.warning,
                                              color: black,
                                              size: Responsive.getHeightValue(
                                                  30)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Responsive.getHeightValue(20),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  JackSelectableRoundedButton(
                                      padding: 60,
                                      height: 44,
                                      withShader: true,
                                      radius: 30,
                                      isSelected: true,
                                      borderColor: darkBlue,
                                      borderWidth: 2,
                                      onTap: () async {
                                        bool isValid = controller.verifyForm();
                                        if (isValid) {
                                          final quickUser =
                                              controller.generateQuickUser();
                                          paymentController
                                              .setQuickPurchaseUser(quickUser);
                                          coreController
                                              .setQuickPurchaseUser(quickUser);
                                          await Future.delayed(
                                              const Duration(milliseconds: 600),
                                              () {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                              (_) {
                                                Navigator.pop(context);
                                                Navigator.popAndPushNamed(
                                                    context, AppRoutes.payment);
                                              },
                                            );
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Comprar',
                                        style: JackFontStyle.bodyBold
                                            .copyWith(color: secondaryColor),
                                      )),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
