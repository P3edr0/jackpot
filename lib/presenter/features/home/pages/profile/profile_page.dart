import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/home/pages/profile/store/profile_controller.dart';
import 'package:jackpot/presenter/features/home/pages/profile/widgets/image_card.dart';
import 'package:jackpot/presenter/features/home/pages/profile/widgets/profile_options_card.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(child:
              Consumer2<ProfileController, CoreController>(
                  builder: (context, controller, coreController, child) {
            return controller.loading || !coreController.haveUser
                ? const Loading()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: Responsive.getHeightValue(80),
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          gradient: primaryGradient,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Responsive.getHeightValue(16),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.getHeightValue(30),
                          horizontal: Responsive.getHeightValue(20),
                        ),
                        decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        width: constraints.maxWidth,
                        child: Consumer<CoreController>(
                            builder: (context, coreController, child) =>
                                Column(children: [
                                  ImageCard(
                                      image: coreController.user!.image!,
                                      name: coreController.user!.name!,
                                      document: coreController.user!.document!,
                                      logout: () {
                                        coreController.logout();
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.home,
                                          (route) => false,
                                        );
                                      }),
                                  SizedBox(
                                    height: Responsive.getHeightValue(16),
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.lock,
                                    label: 'Senha do aplicativo',
                                    subtitle: 'Trocar senha do aplicativo',
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.passwordRecover),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.notifications,
                                    label: 'Notificações',
                                    subtitle:
                                        'Defina quais notificações receber',
                                    onTap: () {},
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.feed,
                                    label: 'Termos, Privacidade e LGPD',
                                    subtitle: 'Termos e exclusão de dados',
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.lgpd),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.smartphone_rounded,
                                    label: 'Celular',
                                    subtitle: coreController.user!.phone!,
                                    onTap: () {},
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.email_rounded,
                                    label: 'Email',
                                    subtitle: coreController.user!.email!,
                                    onTap: () {},
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileOptionsCard(
                                    icon: Icons.contact_support_rounded,
                                    label: 'Ajuda',
                                    subtitle: 'Falar com suporte',
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.help),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ])),
                      )
                    ],
                  );
          })),
        ),
      ),
    ));
  }
}
