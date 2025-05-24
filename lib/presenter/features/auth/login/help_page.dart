import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});
  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
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
                    "Ajuda",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.getHeightValue(20),
                  ),
                  Text(
                    "Teve algum problema com o login ou cadastro no Jackpot",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.titleBold
                        .copyWith(color: black, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: Responsive.getHeightValue(20),
                  ),
                  Text(
                    "Você está tendo dificuldades ou enfrentando algum problema no aplicativo, entre em contato com o nosso suporte o mais rápido possível para que possamos te ajudar.",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.bodyLargeBold.copyWith(color: mediumGrey),
                  ),
                  SizedBox(
                    height: Responsive.getHeightValue(60),
                  ),
                  JackSelectableRoundedButton(
                      width: 260,
                      height: 50,
                      isSelected: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "(xx)xxxxx-xxxx",
                            textAlign: TextAlign.center,
                            style: JackFontStyle.titleBold
                                .copyWith(color: secondaryColor),
                          ),
                        ],
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.preCreateUser)),
                  SizedBox(
                    height: Responsive.getHeightValue(20),
                  ),
                  JackSelectableRoundedButton(
                      width: 260,
                      height: 50,
                      isSelected: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.email,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "jackpot@gmail.com",
                            textAlign: TextAlign.center,
                            style: JackFontStyle.titleBold
                                .copyWith(color: secondaryColor),
                          ),
                        ],
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.preCreateUser)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
