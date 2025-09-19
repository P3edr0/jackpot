import 'package:flutter/material.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/presenter/features/payment/pages/components/widgets/edit_address.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/card_formatter.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class CardPaymentInfo extends StatelessWidget {
  const CardPaymentInfo(
      {super.key,
      required this.totalValue,
      required this.isCreditCard,
      required this.onTap,
      required this.onTapCardInfo,
      required this.showCardInfo,
      required this.address});
  final double totalValue;
  final bool isCreditCard;
  final bool showCardInfo;
  final VoidCallback onTap;
  final VoidCallback onTapCardInfo;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                isCreditCard
                    ? Icons.circle_outlined
                    : Icons.radio_button_checked,
                color: darkBlue,
              ),
              SizedBox(
                width: Responsive.getHeightValue(5),
              ),
              Text(
                'Cartão de débito',
                style: JackFontStyle.bodyLargeBold.copyWith(color: darkBlue),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Responsive.getHeightValue(10),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                isCreditCard
                    ? Icons.radio_button_checked
                    : Icons.circle_outlined,
                color: darkBlue,
              ),
              SizedBox(
                width: Responsive.getHeightValue(5),
              ),
              Text(
                'Cartão de crédito',
                style: JackFontStyle.bodyLargeBold.copyWith(color: darkBlue),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Responsive.getHeightValue(20),
        ),
        InkWell(
          onTap: onTapCardInfo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dados do cartão',
                style: JackFontStyle.titleBold.copyWith(color: darkBlue),
              ),
              AnimatedRotation(
                turns: showCardInfo ? 0.5 : 0,
                duration: const Duration(milliseconds: 500),
                child: const Icon(
                  Icons.expand_more,
                  color: darkBlue,
                ),
              )
            ],
          ),
        ),
        Consumer<PaymentController>(builder: (context, controller, child) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: !showCardInfo
                ? const SizedBox()
                : Form(
                    key: controller.cardFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Responsive.getHeightValue(16),
                        ),
                        JackTextfield(
                            controller: controller.cardNumber,
                            formatter: [CardFormatter()],
                            inputType: TextInputType.number,
                            validator: (value) {
                              String content = value as String;
                              content = content.replaceAll(' ', '');
                              if (content.length < 14) {
                                return 'Insira um número de cartão válido.';
                              }
                              return null;
                            },
                            hint: 'Número do cartão de crédito'),
                        SizedBox(
                          height: Responsive.getHeightValue(16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: JackTextfield(
                                  controller: controller.expireCardDate,
                                  formatter: [DateCardFormatter.maskFormatter],
                                  inputType: TextInputType.number,
                                  validator: (value) {
                                    final content = value as String;
                                    if (content.length < 7) {
                                      return 'Ex: 12/2025';
                                    }
                                    String year = content.split('/')[1];

                                    final handledYear = int.parse(year);

                                    final currentYear = DateTime.now().year;
                                    if (handledYear > 2100 ||
                                        handledYear < currentYear) {
                                      return 'Data inválida';
                                    }
                                    return null;
                                  },
                                  hint: 'Validade'),
                            ),
                            SizedBox(
                              width: Responsive.getHeightValue(20),
                            ),
                            Expanded(
                                child: JackTextfield(
                                    formatter: [CardCVVFormatter.maskFormatter],
                                    controller: controller.cardCvv,
                                    inputType: TextInputType.number,
                                    validator: (value) {
                                      final content = value as String;
                                      if (content.length < 3) {
                                        return 'Insira um número de CVV válido';
                                      }
                                      return null;
                                    },
                                    hint: 'CVV')),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.getHeightValue(20),
                        ),
                        Text(
                          'Dados do titular do cartão',
                          style:
                              JackFontStyle.titleBold.copyWith(color: darkBlue),
                        ),
                        SizedBox(
                          height: Responsive.getHeightValue(10),
                        ),
                        JackTextfield(
                            validator: (value) {
                              final handledValue = value as String;
                              if (handledValue.trim().isEmpty) {
                                return 'Insira um nome válido';
                              }
                              return null;
                            },
                            controller: controller.nameOwnerCard,
                            formatter: [UserNameCardFormatter()],
                            hint: 'Nome impresso no cartão'),
                        SizedBox(
                          height: Responsive.getHeightValue(20),
                        ),
                        Text(
                          'CPF do titular do cartão',
                          style:
                              JackFontStyle.titleBold.copyWith(color: darkBlue),
                        ),
                        SizedBox(
                          height: Responsive.getHeightValue(10),
                        ),
                        JackTextfield(
                          controller: controller.cpfOwnerCard,
                          formatter: [CpfFormatter.maskFormatter],
                          inputType: TextInputType.number,
                          hint: 'CPF do titular do cartão',
                          validator: (value) {
                            return controller.validDocument();
                          },
                          onChanged: (value) async {
                            controller.setDocumentMask();
                            if (value.length == 14) {
                              await controller.checkDocument();
                              if (controller.hasError) {
                                ErrorDialog.show(
                                    "Erro", controller.exception!, context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
          );
        }),
        SizedBox(
          height: Responsive.getHeightValue(20),
        ),
        Text(
          'Endereço de cobrança',
          style: JackFontStyle.titleBold.copyWith(color: darkBlue),
        ),
        SizedBox(
          height: Responsive.getHeightValue(10),
        ),
        Consumer<PaymentController>(builder: (context, controller, child) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: controller.showEditAddress
                ? const EditAddress()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.radio_button_checked,
                        color: darkBlue,
                      ),
                      SizedBox(
                        width: Responsive.getHeightValue(10),
                      ),
                      Expanded(
                        child: Text(
                          address,
                          style: JackFontStyle.body.copyWith(color: darkBlue),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.getHeightValue(10),
                      ),
                      Center(
                        child: InkWell(
                          onTap: controller.setShowEditAddress,
                          child: Text(
                            'Alterar endereço',
                            style: JackFontStyle.titleBold
                                .copyWith(color: darkBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ],
    );
  }
}
