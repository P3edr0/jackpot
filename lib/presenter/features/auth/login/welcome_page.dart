import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
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
            Icon(Icons.how_to_reg_rounded,
                color: darkBlue, size: Responsive.getHeightValue(70)),
            SizedBox(
              height: Responsive.getHeightValue(10),
            ),
            Text(
              "Olá! É bom te ver novamente.",
              textAlign: TextAlign.center,
              style: JackFontStyle.titleBold
                  .copyWith(color: black, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Text(
              "Bem vindo(a) de volta!\nPara fazer o login clique em prosseguir.",
              textAlign: TextAlign.center,
              style: JackFontStyle.bodyLargeBold.copyWith(color: mediumGrey),
            ),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            InkWell(
              onTap: () async =>
                  Navigator.pushReplacementNamed(context, AppRoutes.help),
              child: Text(
                "Não lembro do meu cadastro",
                textAlign: TextAlign.center,
                style: JackFontStyle.titleBold.copyWith(color: darkBlue),
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
            JackSelectableRoundedButton(
                width: 250,
                height: 50,
                isSelected: true,
                child: Text(
                  "Prosseguir",
                  textAlign: TextAlign.center,
                  style:
                      JackFontStyle.titleBold.copyWith(color: secondaryColor),
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.password)),
          ],
        ),
      ),
    );
  }
}
