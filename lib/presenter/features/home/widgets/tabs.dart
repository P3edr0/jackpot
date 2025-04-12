import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/components/buttons/rectangle_button.dart';
import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';
import 'package:jackpot/utils/app_assets.dart';
import 'package:jackpot/utils/enums/home_tab.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            JackRectangleButton(
              onTap: () => controller.setSelectedTab(HomeTab.extra),
              isSelected: controller.selectedTab.isExtra,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.flameSvg,
                    semanticsLabel: 'Extra',
                    height: Responsive.getHeightValue(14),
                  ),
                  SizedBox(
                    width: Responsive.getHeightValue(8),
                  ),
                  Text("Extra",
                      style:
                          JackFontStyle.title.copyWith(color: secondaryColor)),
                ],
              ),
            ),
            SizedBox(
              width: Responsive.getHeightValue(10),
            ),
            JackRectangleButton(
              onTap: () => controller.setSelectedTab(HomeTab.sports),
              isSelected: controller.selectedTab.isSports,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.ballSvg,
                    semanticsLabel: 'Esporte',
                    height: Responsive.getHeightValue(14),
                  ),
                  SizedBox(
                    width: Responsive.getHeightValue(8),
                  ),
                  Text("Esporte",
                      style:
                          JackFontStyle.title.copyWith(color: secondaryColor)),
                ],
              ),
            ),
            SizedBox(
              width: Responsive.getHeightValue(10),
            ),
            JackRectangleButton(
              onTap: () => controller.setSelectedTab(HomeTab.show),
              isSelected: controller.selectedTab.isShow,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.grassSvg,
                    semanticsLabel: 'Shows',
                    height: Responsive.getHeightValue(14),
                  ),
                  SizedBox(
                    width: Responsive.getHeightValue(8),
                  ),
                  Text("Shows",
                      style:
                          JackFontStyle.title.copyWith(color: secondaryColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
