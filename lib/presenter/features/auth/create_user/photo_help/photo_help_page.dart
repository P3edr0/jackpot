import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/store/face_capture_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PhotoHelpPage extends StatefulWidget {
  const PhotoHelpPage({
    super.key,
  });
  @override
  PhotoHelpPageState createState() => PhotoHelpPageState();
}

class PhotoHelpPageState extends State<PhotoHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          const SizedBox(
            height: 50,
          ),
          Text(
            "Dicas para uma foto eficiente",
            textAlign: TextAlign.center,
            style: JackFontStyle.h4Bold
                .copyWith(color: black, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: Responsive.getHeightValue(20),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30, left: 25),
                  child: Image.asset(
                    AppAssets.selfieTrickOne,
                    fit: BoxFit.fill,
                    width: Responsive.getHeightValue(60),
                    height: Responsive.getHeightValue(60),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                margin: const EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  'Faça a foto em um fundo claro e sem texturas diferentes (ex.: parede)',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30, left: 25),
                  child: Image.asset(
                    AppAssets.selfieTrickTwo,
                    fit: BoxFit.fill,
                    width: Responsive.getHeightValue(60),
                    height: Responsive.getHeightValue(60),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                margin: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Procure um lugar bem iluminado, mas evite tirar fotos com foco de luz atrás da pessoa',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30, left: 25),
                  child: Image.asset(
                    AppAssets.selfieTrickThree,
                    fit: BoxFit.contain,
                    width: Responsive.getHeightValue(60),
                    height: Responsive.getHeightValue(60),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                margin: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Não utilize acessórios, como óculos, máscara, boné etc.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30, left: 25),
                  child: Image.asset(
                    AppAssets.selfieTrickFour,
                    fit: BoxFit.contain,
                    width: Responsive.getHeightValue(60),
                    height: Responsive.getHeightValue(60),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                margin: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Enquadre somente o rosto de frente na foto, sem sorrir',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<FaceCaptureController>(
              builder: (context, controller, child) =>
                  JackSelectableRoundedButton(
                width: 250,
                height: 50,
                isSelected: true,
                child: Text(
                  "Tirar nova foto",
                  textAlign: TextAlign.center,
                  style:
                      JackFontStyle.titleBold.copyWith(color: secondaryColor),
                ),
                onTap: () async {
                  controller.setFile(null);
                  Navigator.pushNamed(context, AppRoutes.captureFace);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
