import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_item.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/shared/utils/routes/route_observer.dart';
import 'package:provider/provider.dart';

import '../../../../../../../shared/utils/app_assets.dart';
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
    return Consumer<RouteStackObserver>(builder: (context, controller, _) {
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
                  if (!(controller.currentRoute == AppRoutes.home)) {
                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                },
                label: 'Home',
                svgIcon: AppAssets.homeSvg,
                isSelected: controller.selectedNavBar.isHome,
              ),
              JackNavbarItem(
                onTap: () async {
                  if (!(controller.currentRoute == AppRoutes.myJackpots)) {
                    Navigator.pushNamed(context, AppRoutes.myJackpots);
                  }
                },
                label: 'Meus Jacks',
                svgIcon: AppAssets.bagSvg,
                isSelected: controller.selectedNavBar.isJacks,
              ),
              CentralJackNavbarItem(
                onTap: () {
                  if (!(controller.currentRoute == AppRoutes.home)) {
                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                },
                svgIcon: AppAssets.crownSvg,
              ),
              JackNavbarItem(
                onTap: () {},

                //  controller
                //     .setSelectedNavBar(JackTabNavigationOptions.winners),
                label: 'Ganhadores',
                svgIcon: AppAssets.trophy,
                isSelected: controller.selectedNavBar.isWinners,
              ),
              JackNavbarItem(
                onTap: () {},
                // controller
                //     .setSelectedNavBar(JackTabNavigationOptions.wallet),
                label: 'Carteira',
                svgIcon: AppAssets.walletSvg,
                isSelected: controller.selectedNavBar.isWallet,
              ),
            ],
          ));
    });
  }
}
