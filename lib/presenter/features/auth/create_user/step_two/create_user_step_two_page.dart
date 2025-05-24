import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/step_by_step.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_two/store/create_user_step_two_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_two/widgets/selfie_tricks.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/cep_formatter.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/shared/utils/validators/empty_field_validator.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class CreateUserStepTwoPage extends StatefulWidget {
  const CreateUserStepTwoPage({super.key});
  @override
  CreateUserStepTwoPageState createState() => CreateUserStepTwoPageState();
}

class CreateUserStepTwoPageState extends State<CreateUserStepTwoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: JackCircularButton(
                      onTap: () => Navigator.pop(context),
                      size: 50,
                      child: const Icon(
                        Icons.arrow_back,
                        color: secondaryColor,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Text(
                    "Preencha seus dados",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.h4Bold
                        .copyWith(color: black, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: Responsive.getHeightValue(20),
                  ),
                  SizedBox(
                      height: Responsive.getHeightValue(50),
                      child: const StepByStep(steps: 3, currentStep: 2)),
                  SizedBox(
                    height: Responsive.getHeightValue(40),
                  ),
                  Consumer<CreateUserStepTwoController>(
                    builder: (context, controller, child) => Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          JackTextfield(
                            label: Text(
                              'CEP',
                              style: JackFontStyle.bodyBold
                                  .copyWith(color: darkBlue),
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
                                  ErrorDialog.show("CEP Inválido",
                                      controller.exception!, context);
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
                                style: JackFontStyle.bodyBold
                                    .copyWith(color: darkBlue),
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
                                      style: JackFontStyle.bodyBold
                                          .copyWith(color: darkBlue),
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
                                      style: JackFontStyle.bodyBold
                                          .copyWith(color: darkBlue),
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
                                style: JackFontStyle.bodyBold
                                    .copyWith(color: darkBlue),
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
                                      style: JackFontStyle.bodyBold
                                          .copyWith(color: darkBlue),
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
                                      style: JackFontStyle.bodyBold
                                          .copyWith(color: darkBlue),
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Para concluir, vamos finalizar com a foto do seu rosto",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.bodyLargeBold.copyWith(
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SelfieTricks(),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<CreateUserStepTwoController>(
              builder: (context, controller, child) =>
                  JackSelectableRoundedButton(
                      width: 250,
                      height: 50,
                      isSelected: true,
                      child: Text(
                        "Tirar foto",
                        textAlign: TextAlign.center,
                        style: JackFontStyle.titleBold
                            .copyWith(color: secondaryColor),
                      ),
                      onTap: () async {
                        final isValid = controller.verifyForm();
                        if (isValid) {
                          Navigator.pushNamed(context, AppRoutes.captureFace);
                        } else {
                          if (controller.hasError) {
                            ErrorDialog.show(
                                "Erro", controller.exception!, context);
                          }
                        }
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
