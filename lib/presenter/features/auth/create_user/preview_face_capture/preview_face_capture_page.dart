import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/error_dialog.dart';
import 'package:jackpot/components/loadings/loading_button.dart';
import 'package:jackpot/components/step_by_step.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/create_user_store/create_user_controller.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/store/face_capture_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PreviewCapturedFacePage extends StatefulWidget {
  final String title;
  const PreviewCapturedFacePage(
      {super.key, this.title = 'PreviewFaceCapturePage'});
  @override
  PreviewCapturedFacePageState createState() => PreviewCapturedFacePageState();
}

class PreviewCapturedFacePageState extends State<PreviewCapturedFacePage> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    // Future.delayed(const Duration(seconds: 0)).then((_) async {
    //   //store.foto = await store.verificafoto();
    //   setState(() {});
    super.initState();
    // });
  }

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
          Text(
            "Veja como ficou sua foto",
            textAlign: TextAlign.center,
            style: JackFontStyle.h4Bold
                .copyWith(color: black, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: Responsive.getHeightValue(20),
          ),
          SizedBox(
              height: Responsive.getHeightValue(50),
              child: const StepByStep(steps: 3, currentStep: 3)),
          Consumer<FaceCaptureController>(
            builder: (context, controller, child) => Container(
              margin: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                backgroundColor: darkBlue,
                radius: 82,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(controller.file!),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: JackOutlineButton(
              height: 50,
              width: 160,
              borderColor: darkBlue,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.photoHelp);
              },
              child: Text(
                "Alterar foto",
                textAlign: TextAlign.center,
                style: JackFontStyle.titleBold.copyWith(color: darkBlue),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Pronto",
            textAlign: TextAlign.center,
            style: JackFontStyle.h4Bold.copyWith(color: black),
          ),
          Text(
            'Agora vamos validar sua Foto!',
            textAlign: TextAlign.center,
            style: JackFontStyle.titleBold.copyWith(color: black),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<CreateUserController>(
              builder: (context, controller, child) =>
                  JackSelectableRoundedButton(
                width: 250,
                height: 50,
                isSelected: true,
                child: controller.loading
                    ? const LoadingButton(
                        color: secondaryColor,
                      )
                    : Text(
                        "Finalizar",
                        textAlign: TextAlign.center,
                        style: JackFontStyle.titleBold
                            .copyWith(color: secondaryColor),
                      ),
                onTap: () async {
                  // if (controller.loading) return;
                  await controller.createUser();
                  final bool isValid = controller.userCreated;
                  if (isValid && context.mounted) {
                    final coreController =
                        Provider.of<CoreController>(context, listen: false);
                    await coreController.externalLogin(controller.email,
                        controller.password, CredentialType.email);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.home,
                        (route) => false,
                      );
                    });
                  } else {
                    if (controller.hasError) {
                      ErrorDialog.show("Erro", controller.exception!, context);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
