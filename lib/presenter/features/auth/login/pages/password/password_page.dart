import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/loadings/loading_button.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/password/store/password_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/password_formatter.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/shared/utils/routes/route_observer.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});
  @override
  PasswordPageState createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            const Spacer(),
            Text(
              "Senha do aplicativo",
              textAlign: TextAlign.center,
              style: JackFontStyle.h4Bold
                  .copyWith(color: black, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Text(
              "Digite a senha que você criou anteriormente",
              textAlign: TextAlign.center,
              style: JackFontStyle.bodyLargeBold.copyWith(color: mediumGrey),
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Consumer<PasswordController>(
              builder: (context, controller, child) => Form(
                key: controller.passwordKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: JackTextfield(
                    controller: controller.passwordController,
                    formatter: [PasswordFormatter.maskFormatter],
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
                ),
              ),
            ),
            SizedBox(
              height: Responsive.getHeightValue(40),
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.passwordRecover),
              child: Text(
                "Esqueceu sua senha?",
                textAlign: TextAlign.center,
                style: JackFontStyle.bodyLargeBold.copyWith(
                    color: darkBlue,
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.underline,
                    decorationColor: darkBlue),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PasswordController>(
              builder: (context, controller, child) => JackRoundedButton(
                  height: 50,
                  width: 250,
                  child: controller.loading
                      ? const LoadingButton(
                          color: secondaryColor,
                        )
                      : Text(
                          "Confirmar",
                          textAlign: TextAlign.center,
                          style: JackFontStyle.titleBold
                              .copyWith(color: secondaryColor),
                        ),
                  onTap: () async {
                    final coreController =
                        Provider.of<CoreController>(context, listen: false);
                    final isValid = controller.verifyPassword();
                    if (isValid) {
                      await coreController.login();

                      if (controller.hasError && context.mounted) {
                        ErrorDialog.show("Falha ao fazer login",
                            controller.exception!, context);
                        return;
                      }
                      if (coreController.comingFromPayment) {
                        coreController.setComingFromPayment(false);
                        final routeObserver = RouteStackObserver.instance();
                        if (routeObserver.currentStackNames
                            .contains(AppRoutes.shoppingCart)) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.payment,
                              ModalRoute.withName(AppRoutes.shoppingCart));
                          return;
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.payment,
                            ModalRoute.withName(AppRoutes.couponSelect));
                        return;
                      }
                      if (coreController.haveUser && context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.home,
                          (route) => false,
                        );
                        return;
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
