import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/datepickers/date_input.dart';
import 'package:jackpot/components/step_by_step.dart';
import 'package:jackpot/components/textfields/textfield.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({
    super.key,
  });
  @override
  PasswordRecoverPageState createState() => PasswordRecoverPageState();
}

class PasswordRecoverPageState extends State<PasswordRecoverPage> {
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
                    "Recuperar senha",
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
            SizedBox(
                height: Responsive.getHeightValue(50),
                child: const StepByStep(steps: 3, currentStep: 2)),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Primeiro precisamos confirmar alguns dados:",
                  textAlign: TextAlign.center,
                  style: JackFontStyle.title.copyWith(color: darkBlue),
                ),
                SizedBox(
                  height: Responsive.getHeightValue(20),
                ),
                JackTextfield(
                  enable: false,
                  controller:
                      TextEditingController(text: 'kamargopedro@gmail.com'),
                  hint: 'kamargopedro@gmail.com',
                ),
                SizedBox(
                  height: Responsive.getHeightValue(20),
                ),
                JackDateInput(
                  dayController: TextEditingController(),
                  monthController: TextEditingController(),
                  yearController: TextEditingController(),
                ),
                SizedBox(
                  height: Responsive.getHeightValue(40),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.help),
                  child: Text(
                    "PRECISO DE AJUDA",
                    textAlign: TextAlign.center,
                    style: JackFontStyle.bodyLargeBold.copyWith(
                      fontWeight: FontWeight.w900,
                      color: darkBlue,
                    ),
                  ),
                ),
              ]),
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
                  "Avançar",
                  textAlign: TextAlign.center,
                  style:
                      JackFontStyle.titleBold.copyWith(color: secondaryColor),
                ),
                onTap: () => Navigator.pushNamed(
                    context, AppRoutes.passwordRecoverEmail)),
          ],
        ),
      ),
    );
  }
}
