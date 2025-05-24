import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/components/cards/jack_card.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/sports_filter/sports_filter.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../shared/utils/enums/sports_filters_type.dart';

class SportContent extends StatelessWidget {
  const SportContent({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text("Categorias",
              style: JackFontStyle.bodyLarge
                  .copyWith(fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          height: Responsive.getHeightValue(16),
        ),
        SportsFilter(constraints: constraints),
        SizedBox(
          height: Responsive.getHeightValue(26),
        ),
        Selector<HomeController, SportsFiltersType>(
          selector: (_, controller) => controller.sportsFiltersType,
          builder: (_, filter, __) => Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 16),
                  child: JackSelectableRoundedButton(
                      isSelected: !filter.isChampionship,
                      onTap: () => controller
                          .setSportsFiltersType(SportsFiltersType.teams),
                      label: 'Times')),
              JackSelectableRoundedButton(
                  isSelected: !filter.isTeams,
                  onTap: () => controller
                      .setSportsFiltersType(SportsFiltersType.championship),
                  label: 'Campeonatos'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                    onTap: () =>
                        controller.setSportsFiltersType(SportsFiltersType.all),
                    child: SizedBox(
                      height: Responsive.getHeightValue(32),
                      child: Text('ver tudo',
                          style:
                              JackFontStyle.body.copyWith(color: mediumGrey)),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          height: Responsive.getHeightValue(21),
        ),
        Selector<HomeController, bool>(
            selector: (_, control) => control.selectedSport.isSoccer,
            builder: (_, isSoccer, __) {
              return isSoccer
                  ? Selector<HomeController, List<ResumeJackpotEntity>>(
                      selector: (_, control) => control.sportJacks,
                      builder: (_, jacks, __) {
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final jack = jacks[index];
                              return JackCard(
                                onTap: () {
                                  if (jack.jackpotType!.isChampionship) {
                                    final championshipController = Provider.of<
                                            JackpotChampionshipController>(
                                        context,
                                        listen: false);
                                    final championshipJack =
                                        jack as ChampionshipEntity;
                                    championshipController
                                        .setSelectedChampionshipData(
                                      newId: championshipJack.id.toString(),
                                      newBanner: jack.banner,
                                      newChampionshipName: jack.name,
                                    );
                                    Navigator.pushNamed(
                                        context, AppRoutes.jackpotChampionship);
                                    return;
                                  }
                                  final teamController =
                                      Provider.of<JackpotTeamController>(
                                          context,
                                          listen: false);
                                  final teamJack = jack as TeamEntity;
                                  teamController.setSelectedTeamData(
                                    newId: teamJack.id.toString(),
                                    newBanner: jack.banner,
                                    newTeamName: jack.name,
                                  );
                                  Navigator.pushNamed(
                                      context, AppRoutes.jackpotTeam);
                                },
                                title: jack.title,
                                constraints: constraints,
                                image: jack.banner,
                                potValue: jack.potValue,
                                setFavorite: () =>
                                    controller.setFavoriteSportsJacks(index),
                                isFavorite: jack.isFavorite,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                            itemCount: jacks.length);
                      })
                  : Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: darkBlue
                          // gradient: primaryGradient,
                          ),
                      height: Responsive.getHeightValue(200),
                      width: double.infinity,
                      child: Text(
                        "Modalidade disponível em breve",
                        style: JackFontStyle.h3Bold
                            .copyWith(color: secondaryColor),
                        textAlign: TextAlign.center,
                      ));
            })
      ],
    );
  }
}
