import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/loadings/loading_button.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/presenter/features/auth/create_user/create_user_store/create_user_controller.dart';
import 'package:jackpot/presenter/features/auth/login/login_store/login_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/credential/store/credential_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class CredentialPage extends StatefulWidget {
  const CredentialPage({super.key});
  @override
  CredentialPageState createState() => CredentialPageState();
}

class CredentialPageState extends State<CredentialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: SafeArea(
            child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight,
                      color: secondaryColor,
                      child: Image.asset(
                        AppAssets.faceIdAnimation,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: JackCircularButton(
                            onTap: () async => Navigator.pushReplacementNamed(
                                context, AppRoutes.home),
                            size: 50,
                            child: const Icon(
                              Icons.arrow_back,
                              color: secondaryColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Text(
                      'Informe sua credencial',
                      style: JackFontStyle.titleBold,
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Consumer<CredentialController>(
                      builder: (context, controller, child) => Form(
                        key: controller.credentialKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: JackTextfield(
                              controller: controller.credentialController,
                              formatter: [CpfFormatter.maskFormatter],
                              onChanged: (value) {
                                controller.changeCredentialMask();
                              },
                              validator: (value) {
                                return controller.validCredential();
                              },
                              hint: 'CPF ou Email'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Consumer<CredentialController>(
                      builder: (context, controller, child) =>
                          JackRoundedButton(
                              height: 50,
                              width: 250,
                              child: controller.loading
                                  ? const LoadingButton(
                                      color: secondaryColor,
                                    )
                                  : Text(
                                      "Entrar",
                                      textAlign: TextAlign.center,
                                      style: JackFontStyle.titleBold
                                          .copyWith(color: secondaryColor),
                                    ),
                              onTap: () async {
                                final loginController =
                                    Provider.of<LoginController>(context,
                                        listen: false);
                                final isValid = controller.verifyUser();
                                if (isValid) {
                                  final bool haveProfile =
                                      await loginController.checkCredential();

                                  if (controller.hasError && context.mounted) {
                                    ErrorDialog.show("Falha ao fazer login",
                                        controller.exception!, context);
                                    return;
                                  }
                                  if (haveProfile && context.mounted) {
                                    Navigator.pushNamed(
                                        context, AppRoutes.welcome);
                                    return;
                                  } else {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.pushNamed(
                                          context, AppRoutes.preCreateUser);
                                      return;
                                    });
                                    final createUserController =
                                        Provider.of<CreateUserController>(
                                            context,
                                            listen: false);
                                    createUserController.setCredentialEmail(
                                        controller
                                            .currentCredentialType.isEmail,
                                        controller.credential);
                                  }
                                }
                              }),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
