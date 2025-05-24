import 'package:flutter/material.dart';
import 'package:jackpot/components/appbar/appbar.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/banner_card.dart';
import 'package:jackpot/components/cards/championship_jack_card.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/presenter/features/jackpot/store/jackpot_controller.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';

class JackpotTeamPage extends StatefulWidget {
  const JackpotTeamPage({super.key});

  @override
  State<JackpotTeamPage> createState() => _JackpotTeamPageState();
}

class _JackpotTeamPageState extends State<JackpotTeamPage> {
  late JackpotTeamController controller;
  late JackpotController jackpotController;
  @override
  void initState() {
    super.initState();

    controller = Provider.of<JackpotTeamController>(context, listen: false);
    jackpotController = Provider.of<JackpotController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getTeamJackpots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Selector<JackpotTeamController, bool>(
            selector: (context, controller) => controller.isLoading,
            builder: (context, isLoading, child) =>
                isLoading ? const SizedBox() : const JackBottomNavigationBar()),
        body: Container(
          decoration: const BoxDecoration(color: secondaryColor),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                  child: Selector<JackpotTeamController, bool>(
                      selector: (context, controller) => controller.isLoading,
                      builder: (context, isLoading, child) {
                        return isLoading
                            ? const Loading()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: Responsive.getHeightValue(
                                                  270),
                                            ),
                                            Selector<JackpotTeamController,
                                                JackFiltersType>(
                                              selector: (_, controller) =>
                                                  controller.jackFiltersType,
                                              builder: (_, filter, __) => Row(
                                                children: [
                                                  JackSelectableRoundedButton(
                                                      isSelected: filter.isAll,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .all),
                                                      label: 'Todos'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  JackSelectableRoundedButton(
                                                      isSelected: filter.isPots,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .pots),
                                                      label: 'Potes'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  JackSelectableRoundedButton(
                                                      isSelected:
                                                          filter.isAwards,
                                                      onTap: () => controller
                                                          .setJackFiltersType(
                                                              JackFiltersType
                                                                  .awards),
                                                      label: 'Prêmios'),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Responsive.getHeightValue(16),
                                            ),
                                            Selector<JackpotTeamController,
                                                    List<JackpotEntity>>(
                                                selector: (context,
                                                        controller) =>
                                                    controller
                                                        .teamCompleteJackpots,
                                                builder:
                                                    (context, jackpots, child) {
                                                  return Column(
                                                    children: jackpots
                                                        .map((jack) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 16),
                                                            child:
                                                                ChampionshipJackCard(
                                                              onTap: () {
                                                                final jackController =
                                                                    Provider.of<
                                                                            JackpotController>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                jackController
                                                                    .setSelectedJackpot(
                                                                        jack);
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .couponSelect);
                                                              },
                                                              title: jack
                                                                  .championship
                                                                  .name,
                                                              constraints:
                                                                  constraints,
                                                              image:
                                                                  jack.banner,
                                                              date: jack
                                                                  .matchTime,
                                                              homeTeam:
                                                                  jack.homeTeam,
                                                              visitTeam: jack
                                                                  .visitorTeam,
                                                              isFavorite: true,
                                                              setFavorite:
                                                                  () {},
                                                            )))
                                                        .toList(),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Responsive.getHeightValue(
                                                      16)),
                                          decoration: const BoxDecoration(
                                              gradient: secondaryGradient,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20))),
                                          width: constraints.maxWidth,
                                          height:
                                              Responsive.getHeightValue(180),
                                          child: Selector<JackpotTeamController,
                                              String>(
                                            selector: (context, controller) =>
                                                controller.selectedTeamName,
                                            builder: (context, label, child) =>
                                                JackAppBar.transparent(
                                              title: label,
                                              alignment:
                                                  MainAxisAlignment.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: Responsive.getHeightValue(100),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Selector<
                                                  JackpotTeamController,
                                                  String>(
                                                selector:
                                                    (context, controller) =>
                                                        controller
                                                            .selectedTeamBanner,
                                                builder:
                                                    (context, banner, child) =>
                                                        BannerCard(
                                                  image: banner,
                                                ),
                                              ))),
                                    ],
                                  ),
                                ],
                              );
                      })),
            ),
          ),
        ));
  }
}
