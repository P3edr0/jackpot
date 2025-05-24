import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';

class PreLoginInfoPage extends StatefulWidget {
  const PreLoginInfoPage({
    super.key,
  });
  @override
  PreLoginInfoPageState createState() => PreLoginInfoPageState();
}

class PreLoginInfoPageState extends State<PreLoginInfoPage> {
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
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: JackCircularButton(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.home),
                    size: 50,
                    child: const Icon(
                      Icons.arrow_back,
                      color: secondaryColor,
                    )),
              ),
            ),
            Text(
              "Assim como você, nossa \n identidade é única!",
              textAlign: TextAlign.center,
              style: JackFontStyle.title.copyWith(color: darkBlue),
            ),
            SizedBox(
              height: Responsive.getHeightValue(40),
            ),
            Container(
              color: Colors.white,
              child: Image.asset(AppAssets.allAppsBanner, scale: 3),
            ),
            SizedBox(
              height: Responsive.getHeightValue(40),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "O seu login e senha é o mesmo em qualquer uma das nossas plataformas!",
                textAlign: TextAlign.center,
                style: JackFontStyle.title.copyWith(color: darkBlue),
              ),
            ),
            SizedBox(height: Responsive.getHeightValue(40)),
            Text("Você é o caminho!",
                textAlign: TextAlign.center,
                style: JackFontStyle.h4Bold.copyWith(color: darkBlue)),
            SizedBox(
              height: Responsive.getHeightValue(40),
            ),
            Container(
              alignment: Alignment.center,
              height: Responsive.getHeightValue(60),
              width: double.infinity,
              decoration: BoxDecoration(gradient: greyGradient),
              child: Text(
                "Clique em Prosseguir para login ou cadastro!",
                textAlign: TextAlign.center,
                style: JackFontStyle.bodyLargeBold.copyWith(color: darkBlue),
              ),
            ),
            Image.asset(
              AppAssets.activeLine,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: Responsive.getHeightValue(8),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    AppAssets.uzerpass,
                    scale: 3,
                  ),
                ),
              ],
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
                child: Text(
                  "Prosseguir",
                  textAlign: TextAlign.center,
                  style:
                      JackFontStyle.titleBold.copyWith(color: secondaryColor),
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.login)),
          ],
        ),
      ),
    );
  }
}
