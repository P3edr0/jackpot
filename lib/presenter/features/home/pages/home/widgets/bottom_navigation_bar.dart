import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_item.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../shared/utils/app_assets.dart';
import '../../../../../../../shared/utils/enums/tab_navigation_options.dart';
import '../../../../../../theme/colors.dart';

class JackBottomNavigationBar extends StatefulWidget {
  const JackBottomNavigationBar({super.key, required});
  @override
  State<StatefulWidget> createState() => _JackBottomNavigationBarState();
}

class _JackBottomNavigationBarState extends State<JackBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<HomeController>(builder: (context, controller, _) {
      if (controller.isLoading) {
        return const SizedBox();
      }

      return Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          width: size.width,
          height: Responsive.getHeightValue(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              JackNavbarItem(
                onTap: () async {
                  if (!controller.selectedTabNavigationOption.isHome) {
                    controller.setSelectedJackNavbarTab(
                        JackTabNavigationOptions.home);
                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                },
                label: 'Home',
                svgIcon: AppAssets.homeSvg,
                isSelected: controller.selectedTabNavigationOption.isHome,
              ),
              JackNavbarItem(
                onTap: () async {
                  if (!controller.selectedTabNavigationOption.isJacks) {
                    controller.setSelectedJackNavbarTab(
                        JackTabNavigationOptions.jacks);
                    Navigator.pushNamed(context, AppRoutes.myJackpots);
                  }
                },
                label: 'Meus Jacks',
                svgIcon: AppAssets.bagSvg,
                isSelected: controller.selectedTabNavigationOption.isJacks,
              ),
              CentralJackNavbarItem(
                onTap: () => controller
                    .setSelectedJackNavbarTab(JackTabNavigationOptions.home),
                svgIcon: AppAssets.crownSvg,
              ),
              JackNavbarItem(
                onTap: () => controller
                    .setSelectedJackNavbarTab(JackTabNavigationOptions.winners),
                label: 'Ganhadores',
                svgIcon: AppAssets.trophy,
                isSelected: controller.selectedTabNavigationOption.isWinners,
              ),
              JackNavbarItem(
                onTap: () => controller
                    .setSelectedJackNavbarTab(JackTabNavigationOptions.wallet),
                label: 'Carteira',
                svgIcon: AppAssets.walletSvg,
                isSelected: controller.selectedTabNavigationOption.isWallet,
              ),
            ],
          ));
    });
  }
}
