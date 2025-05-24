import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/dialogs/delete_account_dialog.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/home/pages/profile/widgets/profile_options_card.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/store/viewer_docs_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/colors.dart';

class LgpdPage extends StatefulWidget {
  const LgpdPage({super.key});

  @override
  State<LgpdPage> createState() => _LgpdPageState();
}

class _LgpdPageState extends State<LgpdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: constraints.maxHeight,
                      height: Responsive.getHeightValue(80),
                      padding: const EdgeInsets.only(top: 20),
                      decoration:
                          BoxDecoration(gradient: primaryGradient, boxShadow: [
                        BoxShadow(
                            color: darkBlue.withOpacity(0.3),
                            offset: const Offset(0, 1),
                            blurRadius: 0.8,
                            spreadRadius: 0.8)
                      ]),
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
                            'Termos',
                            style: JackFontStyle.titleBold
                                .copyWith(color: secondaryColor),
                          ),
                          const SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Responsive.getHeightValue(16),
                    ),
                    Consumer2<ViewerDocsController, CoreController>(
                        builder: (context, controller, coreController, child) =>
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(children: [
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                                ProfileOptionsCard(
                                    icon: Icons.lock,
                                    label: 'Termo de privacidade',
                                    subtitle: null,
                                    onTap: () {
                                      controller
                                          .setSelectedDoc(DocType.privacy);

                                      Navigator.pushNamed(
                                          context, AppRoutes.viewerDocs);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                ProfileOptionsCard(
                                    icon: Icons.article_rounded,
                                    label: 'Termos de uso',
                                    subtitle: null,
                                    onTap: () {
                                      controller
                                          .setSelectedDoc(DocType.termsOfUse);

                                      Navigator.pushNamed(
                                          context, AppRoutes.viewerDocs);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                ProfileOptionsCard(
                                    icon: Icons.feed,
                                    label: 'LGPD',
                                    subtitle: null,
                                    onTap: () {
                                      controller.setSelectedDoc(DocType.lgpd);

                                      Navigator.pushNamed(
                                          context, AppRoutes.viewerDocs);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                ProfileOptionsCard(
                                  icon: Icons.delete_forever,
                                  label: 'Excluir conta',
                                  subtitle: null,
                                  onTap: () async {
                                    DeleteAccountDialog.show('Excluir conta?',
                                        'Após excluir a conta, não será possível recuperá-la.',
                                        () async {
                                      final success =
                                          await coreController.deleteAccount();
                                      if (success && context.mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.home,
                                          (route) => false,
                                        );
                                      }
                                    }, context);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ))
                  ],
                )),
      ),
    ));
  }
}
