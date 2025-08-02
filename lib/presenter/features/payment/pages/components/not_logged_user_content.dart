import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/match_card_carousel.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class NotLoggedUserContent extends StatelessWidget {
  const NotLoggedUserContent({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: Responsive.getHeightValue(16),
      ),
      Selector<JackpotController, List<SportJackpotEntity>>(
          selector: (context, controller) => controller.selectedSportsJackpot!,
          builder: (context, jackpots, child) => Padding(
                padding: EdgeInsets.only(bottom: Responsive.getHeightValue(16)),
                child: MatchCardCarousel(
                  constraints: constraints,
                  jackpots: jackpots,
                ),
              )),
      SizedBox(
        height: Responsive.getHeightValue(36),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Responsive.getHeightValue(24)),
        child: Column(
          children: [
            JackSelectableRoundedButton(
                height: 44,
                withShader: true,
                radius: 30,
                isSelected: true,
                borderColor: darkBlue,
                borderWidth: 2,
                onTap: () async {
                  Navigator.pushNamed(context, AppRoutes.quickPurchase);
                },
                child: Text(
                  'Compra Rápida',
                  style: JackFontStyle.bodyBold.copyWith(color: secondaryColor),
                )),
            SizedBox(
              height: Responsive.getHeightValue(20),
            ),
            JackSelectableRoundedButton(
                height: 44,
                withShader: true,
                radius: 30,
                isSelected: false,
                borderColor: darkBlue,
                borderWidth: 2,
                onTap: () {
                  final coreController =
                      Provider.of<CoreController>(context, listen: false);
                  coreController.setComingFromPayment(true);
                  if (coreController.haveSession) {
                    Navigator.pushNamed(context, AppRoutes.recoverySession);
                    return;
                  }
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                child: Text(
                  'Fazer Login',
                  style: JackFontStyle.bodyBold.copyWith(color: secondaryColor),
                )),
          ],
        ),
      )
    ]);
  }
}
