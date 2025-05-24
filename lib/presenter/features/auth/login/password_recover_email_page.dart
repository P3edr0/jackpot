import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';

class PasswordRecoverEmailPage extends StatefulWidget {
  const PasswordRecoverEmailPage({
    super.key,
  });
  @override
  PasswordRecoverEmailPageState createState() =>
      PasswordRecoverEmailPageState();
}

class PasswordRecoverEmailPageState extends State<PasswordRecoverEmailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: Responsive.getHeightValue(60),
              decoration: const BoxDecoration(
                gradient: primaryGradient,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: JackCircularButton(
                        onTap: () => Navigator.pop(context),
                        size: 50,
                        child: const Icon(
                          Icons.arrow_back,
                          color: secondaryColor,
                        )),
                  ),
                  Text(
                    "Redefinir sua senha",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.titleBold.copyWith(color: secondaryColor),
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Responsive.getHeightValue(50),
            ),
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 80,
              color: primaryColor,
            ),
            SizedBox(
              height: Responsive.getHeightValue(30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "O e-mail de redefinição de senha foi enviado para kam*****ro@gmail.com",
                textAlign: TextAlign.center,
                style: JackFontStyle.titleBold.copyWith(color: darkBlue),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JackSelectableRoundedButton(
                width: 250,
                height: 50,
                isSelected: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      size: 24,
                      color: secondaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Voltar",
                      textAlign: TextAlign.center,
                      style: JackFontStyle.titleBold
                          .copyWith(color: secondaryColor),
                    ),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.login)),
          ],
        ),
      ),
    );
  }
}
