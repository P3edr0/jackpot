import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/dialogs/info_dialog.dart';
import 'package:jackpot/presenter/features/auth/create_user/create_user_store/create_user_controller.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/store/viewer_docs_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class PreCreateUserPage extends StatefulWidget {
  const PreCreateUserPage({super.key});
  @override
  State<PreCreateUserPage> createState() => _PreCreateUserPageState();
}

class _PreCreateUserPageState extends State<PreCreateUserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: Responsive.getHeightValue(20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: gradientFocusColor,
                      maxRadius: 40,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: darkBlue,
                      ),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(10),
                    ),
                    Consumer<CreateUserController>(
                        builder: (context, controller, child) => Text(
                              controller.credential ?? "",
                              textAlign: TextAlign.center,
                              style: JackFontStyle.titleBold.copyWith(
                                  color: darkBlue, fontWeight: FontWeight.w900),
                            )),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Text(
                      "Você ainda não tem um cadastro aqui no Jackpot.",
                      textAlign: TextAlign.center,
                      style: JackFontStyle.titleBold
                          .copyWith(color: black, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Text(
                      "Faça seu cadastro em apenas alguns minutinhos.",
                      textAlign: TextAlign.center,
                      style: JackFontStyle.bodyLargeBold
                          .copyWith(color: mediumGrey),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(40),
                    ),
                    Text(
                      "Ao criar sua conta você concorda com o nosso",
                      textAlign: TextAlign.center,
                      style: JackFontStyle.bodyLargeBold
                          .copyWith(color: mediumGrey),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    Consumer<ViewerDocsController>(
                      builder: (context, controller, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.setSelectedDoc(DocType.termsOfUse);

                              Navigator.pushNamed(
                                  context, AppRoutes.viewerDocs);
                            },
                            child: Text(
                              "Termos de Uso",
                              textAlign: TextAlign.center,
                              style: JackFontStyle.bodyLarge.copyWith(
                                  color: darkBlue,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decoration: TextDecoration.underline,
                                  decorationColor: darkBlue),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              " e ",
                              textAlign: TextAlign.center,
                              style: JackFontStyle.bodyLarge.copyWith(
                                  color: darkBlue, decorationColor: darkBlue),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.setSelectedDoc(DocType.privacy);

                              Navigator.pushNamed(
                                  context, AppRoutes.viewerDocs);
                            },
                            child: Text(
                              "Política de Privacidade",
                              textAlign: TextAlign.center,
                              style: JackFontStyle.bodyLarge.copyWith(
                                  color: darkBlue,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decoration: TextDecoration.underline,
                                  decorationColor: darkBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.help);
                      },
                      child: Text(
                        "Não lembro do meu cadastro",
                        textAlign: TextAlign.center,
                        style:
                            JackFontStyle.titleBold.copyWith(color: darkBlue),
                      ),
                    ),
                    SizedBox(height: Responsive.getHeightValue(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<CreateUserController>(
                            builder: (context, controller, child) =>
                                Row(children: [
                                  controller.acceptTerms
                                      ? InkWell(
                                          onTap: () {
                                            controller.setAcceptTerms();
                                          },
                                          child: const Icon(
                                            Icons.check_box,
                                            color: darkBlue,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            controller.setAcceptTerms();
                                          },
                                          child: const Icon(
                                            Icons
                                                .check_box_outline_blank_outlined,
                                            color: darkBlue,
                                          ),
                                        ),
                                  SizedBox(
                                      width: Responsive.getHeightValue(10)),
                                  Text(
                                    "Aceito os termos",
                                    style: JackFontStyle.titleBold.copyWith(
                                        color: mediumGrey,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ])),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Selector<CreateUserController, bool>(
        selector: (p0, controller) => controller.acceptTerms,
        builder: (context, isSelected, child) => Padding(
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
                    "Novo cadastro",
                    textAlign: TextAlign.center,
                    style:
                        JackFontStyle.titleBold.copyWith(color: secondaryColor),
                  ),
                  onTap: () {
                    if (isSelected && context.mounted) {
                      Navigator.pushNamed(context, AppRoutes.createUserOne);
                    } else if (!isSelected) {
                      InfoDialog.closeAuto("Atenção",
                          "Aceite os termos para prosseguir", context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
