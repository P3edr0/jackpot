import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/datepickers/date_input.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/dropdowns/dropdown.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/components/selector.dart';
import 'package:jackpot/components/step_by_step.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/presenter/features/auth/create_user/step_one/store/create_user_step_one_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/genders.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/formatters/phone_formatter.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class CreateUserStepOnePage extends StatefulWidget {
  const CreateUserStepOnePage({super.key});
  @override
  State<CreateUserStepOnePage> createState() => _CreateUserStepOnePageState();
}

class _CreateUserStepOnePageState extends State<CreateUserStepOnePage> {
  @override
  void initState() {
    super.initState();

    final controller =
        Provider.of<CreateUserStepOneController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchCountries();
      if (controller.document.isNotEmpty) {
        await controller.checkDocument();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Selector<CreateUserStepOneController, bool>(
        selector: (
          context,
          controller,
        ) =>
            controller.loading,
        builder: (context, loading, child) => loading
            ? const Loading()
            : SingleChildScrollView(
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
                          style: JackFontStyle.h4Bold.copyWith(
                              color: black, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: Responsive.getHeightValue(20),
                        ),
                        SizedBox(
                            height: Responsive.getHeightValue(50),
                            child: const StepByStep(steps: 3, currentStep: 1)),
                        SizedBox(
                          height: Responsive.getHeightValue(20),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Nacionalidade',
                            textAlign: TextAlign.left,
                            style: JackFontStyle.bodyBold
                                .copyWith(color: darkBlue),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.getHeightValue(5),
                        ),
                        Consumer<CreateUserStepOneController>(
                          builder: (context, controller, child) => Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                JackDropdown(
                                    height: Responsive.getHeightValue(300),
                                    isValid: true,
                                    onTap: (_) {},
                                    width: Responsive.getHeightValue(300),
                                    elements: controller.countries
                                        .map((element) => element.name!)
                                        .toList(),
                                    label: 'Nacionalidade',
                                    controller:
                                        controller.nationalityController),
                                SizedBox(
                                  height: Responsive.getHeightValue(20),
                                ),
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
                                    // TODO: INSERIR EM PRODUÇÂO
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
                                SizedBox(
                                  height: Responsive.getHeightValue(20),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Data de nascimento',
                                    textAlign: TextAlign.left,
                                    style: JackFontStyle.bodyBold
                                        .copyWith(color: darkBlue),
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(5),
                                ),
                                JackDateInput(
                                    dayController: controller.dayController,
                                    monthController: controller.monthController,
                                    yearController: controller.yearController),
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
                                    if (handledValue.length < 18) {
                                      return 'Insira um telefone válido';
                                    } else {
                                      controller.handledPhone();
                                    }
                                    return null;
                                  },
                                  formatter: [
                                    PhoneInputFormatter(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Gênero",
                                  textAlign: TextAlign.center,
                                  style: JackFontStyle.bodyLargeBold.copyWith(
                                    color: darkBlue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    JackSelector(
                                      isSelected:
                                          controller.selectedGender.isMale,
                                      label: 'Masc.',
                                      onTap: () =>
                                          controller.setGender(Genders.male),
                                    ),
                                    JackSelector(
                                      isSelected:
                                          controller.selectedGender.isFemale,
                                      label: 'Fem.',
                                      onTap: () =>
                                          controller.setGender(Genders.female),
                                    ),
                                    JackSelector(
                                      isSelected: controller
                                          .selectedGender.isNotInformed,
                                      label: 'Não informar',
                                      onTap: () => controller
                                          .setGender(Genders.notInformed),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Crie uma senha",
                                  textAlign: TextAlign.center,
                                  style: JackFontStyle.bodyLargeBold.copyWith(
                                    color: darkBlue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Mínimo 6 dígitos, apenas números",
                                    textAlign: TextAlign.center,
                                    style: JackFontStyle.bodyLarge.copyWith(
                                      color: darkBlue,
                                    ),
                                  )
                                ]),
                                const SizedBox(
                                  height: 10,
                                ),
                                JackTextfield(
                                  label: Text(
                                    'Senha',
                                    style: JackFontStyle.bodyBold
                                        .copyWith(color: darkBlue),
                                  ),
                                  inputAction: TextInputAction.next,
                                  controller: controller.passwordController,
                                  hint: 'Senha',
                                  suffix: InkWell(
                                      onTap: controller.setIsObscurePassword,
                                      child: controller.isObscurePassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  isObscureText: controller.isObscurePassword,
                                  validator: (value) {
                                    return controller.validPassword();
                                  },
                                  inputType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                JackTextfield(
                                  label: Text(
                                    'Confirmar Senha',
                                    style: JackFontStyle.bodyBold
                                        .copyWith(color: darkBlue),
                                  ),
                                  controller:
                                      controller.confirmPasswordController,
                                  hint: 'Confirmar Senha',
                                  suffix: InkWell(
                                      onTap: controller
                                          .setIsObscureConfirmPassword,
                                      child: controller.isObscureConfirmPassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  isObscureText:
                                      controller.isObscureConfirmPassword,
                                  validator: (value) {
                                    return controller.validConfirmPassword();
                                  },
                                  inputType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
      )),
      bottomNavigationBar: Selector<CreateUserStepOneController, bool>(
        selector: (
          context,
          controller,
        ) =>
            controller.loading,
        builder: (context, loading, child) => loading
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<CreateUserStepOneController>(
                      builder: (context, controller, child) =>
                          JackSelectableRoundedButton(
                        width: 250,
                        height: 50,
                        isSelected: true,
                        child: Text(
                          "Avançar",
                          textAlign: TextAlign.center,
                          style: JackFontStyle.titleBold
                              .copyWith(color: secondaryColor),
                        ),
                        onTap: () async {
                          final isValid = controller.verifyForm();
                          if (isValid) {
                            Navigator.pushNamed(
                                context, AppRoutes.createUserTwo);
                          } else {
                            if (controller.hasError) {
                              ErrorDialog.show(
                                  "Erro", controller.exception!, context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
