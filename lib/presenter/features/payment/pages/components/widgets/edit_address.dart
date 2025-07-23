import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/presenter/features/payment/pages/store/payment_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/cep_formatter.dart';
import 'package:jackpot/shared/utils/validators/empty_field_validator.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(
      builder: (context, controller, child) => Form(
        key: controller.formKey,
        child: Column(
          children: [
            JackTextfield(
              label: Text(
                'CEP',
                style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
              ),
              controller: controller.cepController,
              hint: 'CEP',
              inputAction: TextInputAction.next,
              validator: (value) {
                final handledValue = value as String;
                if (handledValue.length < 6) {
                  return 'Cep inválido';
                }
                return null;
              },
              onChanged: (value) async {
                if (value.length == 9) {
                  await controller.getCepAddress();
                  if (controller.hasError) {
                    ErrorDialog.show(
                        "CEP Inválido", controller.exception!, context);
                  }
                }
              },
              formatter: [CepFormatter.maskFormatter],
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            JackTextfield(
                label: Text(
                  'Logradouro',
                  style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                ),
                controller: controller.streetController,
                hint: 'Logradouro',
                inputAction: TextInputAction.next,
                validator: (value) {
                  final handledValue = value as String;
                  final validator = EmptyFieldValidator();
                  return validator(handledValue);
                }),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: JackTextfield(
                      label: Text(
                        'Número',
                        style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                      ),
                      inputAction: TextInputAction.next,
                      controller: controller.numberController,
                      hint: 'Número',
                      validator: (value) {
                        final handledValue = value as String;
                        final validator = EmptyFieldValidator();
                        return validator(handledValue);
                      }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 5,
                    child: JackTextfield(
                      label: Text(
                        'Complemento',
                        style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                      ),
                      controller: controller.complementController,
                      hint: 'Complemento',
                      inputAction: TextInputAction.next,
                    )),
              ],
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            JackTextfield(
                label: Text(
                  'Bairro',
                  style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                ),
                inputAction: TextInputAction.next,
                controller: controller.neighborhoodController,
                hint: 'Bairro',
                validator: (value) {
                  final handledValue = value as String;
                  final validator = EmptyFieldValidator();
                  return validator(handledValue);
                }),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Row(
              children: [
                Expanded(
                  child: JackTextfield(
                      label: Text(
                        'Cidade',
                        style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                      ),
                      inputAction: TextInputAction.next,
                      controller: controller.cityController,
                      hint: 'Cidade',
                      validator: (value) {
                        final handledValue = value as String;
                        final validator = EmptyFieldValidator();
                        return validator(handledValue);
                      }),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: JackTextfield(
                      label: Text(
                        'Estado',
                        style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                      ),
                      inputAction: TextInputAction.next,
                      controller: controller.stateController,
                      hint: 'Estado',
                      validator: (value) {
                        final handledValue = value as String;
                        final validator = EmptyFieldValidator();
                        return validator(handledValue);
                      }),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JackSelectableRoundedButton(
                    padding: 20,
                    height: 44,
                    withShader: false,
                    radius: 30,
                    isSelected: false,
                    borderColor: darkBlue,
                    borderWidth: 2,
                    onTap: controller.setShowEditAddress,
                    child: Text(
                      'Cancelar',
                      style: JackFontStyle.bodyBold.copyWith(color: darkBlue),
                    )),
                SizedBox(
                  width: Responsive.getHeightValue(20),
                ),
                JackSelectableRoundedButton(
                    padding: 20,
                    height: 44,
                    withShader: true,
                    radius: 30,
                    isSelected: true,
                    borderColor: darkBlue,
                    borderWidth: 2,
                    onTap: controller.saveEditAddress,
                    child: Text(
                      'Salvar',
                      style: JackFontStyle.bodyBold
                          .copyWith(color: secondaryColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
