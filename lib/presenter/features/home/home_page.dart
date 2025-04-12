import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/home/widgets/page_contents/extra_content.dart';
import 'package:jackpot/presenter/features/home/widgets/page_contents/sport_content.dart';
import 'package:jackpot/presenter/features/home/widgets/tabs.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';
import 'package:jackpot/utils/app_assets.dart';
import 'package:jackpot/utils/enums/home_tab.dart';
import 'package:provider/provider.dart';

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
    controller.startHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const JackBottomNavigationBar(),
        body: Container(
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
                                        vertical: Responsive.getHeightValue(16),
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
                                          height: Responsive.getHeightValue(16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Responsive.getHeightValue(
                                                      16)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              JackOutlineButton(
                                                onTap: () async {
                                                  await controller
                                                      .fetchAllJacks();
                                                },
                                                child: Text("Entrar",
                                                    style: JackFontStyle
                                                        .bodyLarge
                                                        .copyWith(
                                                            color:
                                                                secondaryColor)),
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppAssets.notificationSvg,
                                                    semanticsLabel:
                                                        'Shopping Cart',
                                                    height: Responsive
                                                        .getHeightValue(24),
                                                  ),
                                                  SizedBox(
                                                    width: Responsive
                                                        .getHeightValue(30),
                                                  ),
                                                  SvgPicture.asset(
                                                    AppAssets.shoppingCartSvg,
                                                    semanticsLabel:
                                                        'Shopping Cart',
                                                    height: Responsive
                                                        .getHeightValue(24),
                                                  ),
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
        ));
  }
}
