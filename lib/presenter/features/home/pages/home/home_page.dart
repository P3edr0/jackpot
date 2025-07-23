import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/dialogs/quit_app_dialog.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/components/shopping_cart_item.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/page_contents/extra_content.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/page_contents/sport_content.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/tabs.dart';
import 'package:jackpot/presenter/features/shopping_cart/store/shopping_cart_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/tab_navigation_options.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/utils/app_assets.dart';
import '../../../../../../shared/utils/enums/home_tab.dart';
import '../../../../../theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  @override
  void initState() {
    super.initState();

    controller = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!controller.selectedTabNavigationOption.isHome) {
        controller.setSelectedJackNavbarTab(JackTabNavigationOptions.home);
        Navigator.pushNamed(context, AppRoutes.home);
      }
      await controller.startHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const JackBottomNavigationBar(),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }

            bool shouldPop =
                await QuitAppDialog.show('Sair do Jackpot?', "", context);
            if (shouldPop) {
              SystemNavigator.pop();
            }
          },
          child: Container(
            decoration: const BoxDecoration(gradient: primaryGradient),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                    child: Selector<HomeController, bool>(
                        selector: (context, controller) => controller.isLoading,
                        builder: (context, isLoading, child) {
                          return isLoading
                              ? const Loading()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Responsive.getHeightValue(16),
                                          horizontal:
                                              Responsive.getHeightValue(16)),
                                      decoration: const BoxDecoration(
                                          gradient: secondaryGradient,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      width: constraints.maxWidth,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Responsive.getHeightValue(16),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Responsive.getHeightValue(
                                                        16)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Consumer<CoreController>(
                                                  builder: (context,
                                                          coreController,
                                                          child) =>
                                                      coreController.haveUser
                                                          ? InkWell(
                                                              onTap: () => Navigator
                                                                  .pushNamed(
                                                                      context,
                                                                      AppRoutes
                                                                          .profile),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: Responsive
                                                                    .getHeightValue(
                                                                        24),
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        coreController
                                                                            .user!
                                                                            .image!),
                                                              ),
                                                            )
                                                          : coreController
                                                                  .haveSession
                                                              ? InkWell(
                                                                  onTap: () => Navigator
                                                                      .pushNamed(
                                                                          context,
                                                                          AppRoutes
                                                                              .recoverySession),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: Responsive
                                                                        .getHeightValue(
                                                                            24),
                                                                    backgroundImage:
                                                                        NetworkImage(coreController
                                                                            .currentSession!
                                                                            .image),
                                                                  ),
                                                                )
                                                              : JackOutlineButton(
                                                                  onTap: () => Navigator
                                                                      .pushNamed(
                                                                          context,
                                                                          AppRoutes
                                                                              .preLogin),
                                                                  child: Text(
                                                                      "Entrar",
                                                                      style: JackFontStyle
                                                                          .bodyLarge
                                                                          .copyWith(
                                                                              color: secondaryColor)),
                                                                ),
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              AppRoutes
                                                                  .shoppingCart),
                                                      child: SvgPicture.asset(
                                                        AppAssets
                                                            .notificationSvg,
                                                        semanticsLabel:
                                                            'Notifications',
                                                        height: Responsive
                                                            .getHeightValue(24),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Responsive
                                                          .getHeightValue(30),
                                                    ),
                                                    Selector<
                                                        ShoppingCartController,
                                                        int>(
                                                      selector: (ctx,
                                                              shoppingCartController) =>
                                                          shoppingCartController
                                                              .totalCoupons,
                                                      builder: (context,
                                                              quantity,
                                                              child) =>
                                                          JackCartIcon(
                                                        itemCount: quantity,
                                                        onTap: () async =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                AppRoutes
                                                                    .shoppingCart),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.getHeightValue(16),
                                    ),
                                    const Tabs(),
                                    SizedBox(
                                      height: Responsive.getHeightValue(16),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Responsive.getHeightValue(30),
                                      ),
                                      decoration: const BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      width: constraints.maxWidth,
                                      child: Selector<HomeController, HomeTab>(
                                          selector: (context, controller) =>
                                              controller.selectedTab,
                                          builder: (context, tab, child) {
                                            if (tab.isExtra) {
                                              return ExtraContent(
                                                  constraints: constraints);
                                            }
                                            return SportContent(
                                                constraints: constraints);
                                          }),
                                    )
                                  ],
                                );
                        })),
              ),
            ),
          ),
        ));
  }
}
