import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/dialogs/info_dialog.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/payment/pages/components/widgets/card_payment_info.dart';
import 'package:jackpot/presenter/features/payment/pages/components/widgets/pix_payment_info.dart';
import 'package:jackpot/presenter/features/payment/pages/components/widgets/selectable_payment_method.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/payment_type.dart';
import 'package:jackpot/shared/utils/formatters/address_formatter.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class LoggedUserContent extends StatefulWidget {
  const LoggedUserContent({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<LoggedUserContent> createState() => _LoggedUserContentState();
}

late PaymentController controller;
late CoreController coreController;

class _LoggedUserContentState extends State<LoggedUserContent> {
  @override
  void initState() {
    super.initState();
    controller = Provider.of<PaymentController>(context, listen: false);
    coreController = Provider.of<CoreController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PaymentController, bool>(
      selector: (
        context,
        controller,
      ) =>
          controller.isLoading,
      builder: (context, loading, child) => Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: !loading,
        replacement: const Loading(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: Responsive.getHeightValue(20),
          ),
          Column(
            children: [
              InkWell(
                child: Text(
                  '+ Uma chance de pergunta premiada.',
                  style: JackFontStyle.bodyLargeBold
                      .copyWith(color: darkBlue, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: Responsive.getHeightValue(20),
              ),
              Consumer<PaymentController>(
                builder: (context, paymentController, child) => Container(
                    width: widget.constraints.maxWidth,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightGrey),
                    child: Column(children: [
                      InkWell(
                        onTap: () => paymentController.setShowPaymentInfo(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Informações de pagamento',
                              style: JackFontStyle.bodyBold.copyWith(
                                  color: darkBlue, fontWeight: FontWeight.w900),
                            ),
                            AnimatedRotation(
                              turns:
                                  paymentController.showPaymentInfo ? 0.5 : 0,
                              duration: const Duration(milliseconds: 500),
                              child: const Icon(
                                Icons.expand_more,
                                color: darkBlue,
                              ),
                            )
                          ],
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: !controller.showPaymentInfo
                            ? const SizedBox()
                            : Column(
                                children: [
                                  SizedBox(
                                    height: Responsive.getHeightValue(20),
                                  ),
                                  Row(
                                    children: [
                                      SelectablePaymentMethod(
                                        onTap: () => controller
                                            .setPaymentType(PaymentType.pix),
                                        isSelected:
                                            paymentController.paymentType.isPix,
                                        label: 'PIX',
                                      ),
                                      SizedBox(
                                        width: Responsive.getHeightValue(10),
                                      ),
                                      SelectablePaymentMethod(
                                        onTap: () => controller.setPaymentType(
                                            PaymentType.creditCard),
                                        isSelected: !paymentController
                                            .paymentType.isPix,
                                        label: 'Cartão',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Responsive.getHeightValue(16),
                                  ),
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeInOut,
                                    alignment: Alignment.topCenter,
                                    child: paymentController.paymentType.isPix
                                        ? PixPaymentInfo(
                                            totalValue:
                                                paymentController.totalValue!)
                                        : CardPaymentInfo(
                                            totalValue:
                                                paymentController.totalValue!,
                                            isCreditCard: paymentController
                                                .paymentType.isCreditCard,
                                            showCardInfo:
                                                paymentController.showCardInfo,
                                            onTapCardInfo: paymentController
                                                .setShowCardInfo,
                                            address: AddressFormatter.format(
                                                paymentController
                                                    .billingAddress),
                                            onTap: () {
                                              final paymentType =
                                                  paymentController.paymentType;
                                              if (paymentType.isCreditCard) {
                                                paymentController
                                                    .setPaymentType(
                                                        PaymentType.debitCard);
                                                return;
                                              }
                                              paymentController.setPaymentType(
                                                  PaymentType.creditCard);
                                            }),
                                  )
                                ],
                              ),
                      ),
                    ])),
              ),
              SizedBox(
                height: Responsive.getHeightValue(20),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.description,
                    color: mediumGrey,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(('Termos e condições'),
                      style:
                          JackFontStyle.bodyLarge.copyWith(color: mediumGrey)),
                ],
              ),
              SizedBox(
                height: Responsive.getHeightValue(16),
              ),
              Selector<PaymentController, bool>(
                selector: (p0, controller) => controller.acceptTerms,
                builder: (context, termsAccepted, child) => InkWell(
                  onTap: () => controller.setAcceptTerms(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      termsAccepted
                          ? const Icon(
                              Icons.check_box,
                              color: darkBlue,
                              size: 26,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              color: darkBlue,
                              size: 26,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                            ('Li e concordo com os termos de adesão do Cupon de Desconto - Clube de vantagens.'),
                            style: JackFontStyle.bodyLargeBold
                                .copyWith(color: mediumGrey)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.getHeightValue(16),
              ),
              Text(('Termos e condições de compra do cupon de desconto.'),
                  style: JackFontStyle.bodyLargeBold.copyWith(
                      color: darkBlue, decoration: TextDecoration.underline)),
              SizedBox(
                height: Responsive.getHeightValue(20),
              ),
              const Divider(
                color: mediumGrey,
              ),
              SizedBox(
                height: Responsive.getHeightValue(10),
              ),
              Consumer2<CoreController, PaymentController>(
                builder: (context, coreController, controller, child) {
                  dynamic user =
                      coreController.user ?? controller.quickPurchaseUser;
                  return Container(
                      width: widget.constraints.maxWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: lightGrey),
                      child: Column(children: [
                        Text(('Confirmação de pagamento'),
                            style: JackFontStyle.titleBold
                                .copyWith(color: darkBlue)),
                        SizedBox(
                          height: Responsive.getHeightValue(20),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Nome: ',
                                  style: JackFontStyle.bodyLargeBold
                                      .copyWith(color: black)),
                              Expanded(
                                child: Text(user.name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: JackFontStyle.bodyLarge
                                        .copyWith(color: black)),
                              )
                            ]),
                        SizedBox(
                          height: Responsive.getHeightValue(5),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CPF:',
                                  style: JackFontStyle.bodyLargeBold
                                      .copyWith(color: black)),
                              Text(user.document!,
                                  style: JackFontStyle.bodyLarge
                                      .copyWith(color: black)),
                            ]),
                        SizedBox(
                          height: Responsive.getHeightValue(5),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('PRODUTO:',
                                  style: JackFontStyle.bodyLargeBold
                                      .copyWith(color: black)),
                              Text(controller.itemDescription!,
                                  style: JackFontStyle.bodyLarge
                                      .copyWith(color: black))
                            ]),
                        SizedBox(
                          height: Responsive.getHeightValue(16),
                        ),
                        Selector<PaymentController, double>(
                          selector: (p0, controller) => controller.totalValue!,
                          builder: (context, value, child) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                'TOTAL - ${MoneyFormat.toReal(value.toString())}',
                                style: JackFontStyle.titleBold
                                    .copyWith(color: darkBlue)),
                          ),
                        ),
                      ]));
                },
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
                        if (controller.paymentType.isPix) {
                          Navigator.pushNamed(context, AppRoutes.qrCodePix);
                          return;
                        }
                        final isValid = controller.validCardForm();
                        if (isValid) {
                          log('Valido');
                          await controller.getPaymentPublicKey();

                          if (controller.hasError && context.mounted) {
                            await ErrorDialog.show(
                                'Atenção', controller.exception!, context);
                            return;
                          }
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            if (context.mounted) {
                              await InfoDialog.closeAuto('Sucesso',
                                  'Pagamento realizado com sucesso', context);
                              Navigator.pushNamed(
                                  context, AppRoutes.jackpotQuestions);
                            }
                          });
                        }
                        if (controller.hasError) {
                          await ErrorDialog.show(
                              'Atenção', controller.exception!, context);
                          return;
                        }
                        log('Não é Valido');
                      },
                      child: Text(
                        'Comprar',
                        style: JackFontStyle.bodyBold
                            .copyWith(color: secondaryColor),
                      )),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: Responsive.getHeightValue(20),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
