import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/widgets/jack_card.dart';
import 'package:jackpot/presenter/features/home/widgets/sports_filter/sports_filter.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';
import 'package:jackpot/utils/enums/sports_filters_type.dart';
import 'package:provider/provider.dart';

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
                  child: SelectableRoundedButton(
                      isSelected: !filter.isChampionship,
                      onTap: () => controller
                          .setSportsFiltersType(SportsFiltersType.teams),
                      label: 'Times')),
              SelectableRoundedButton(
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
        Selector<HomeController, List<JackpotEntity>>(
            selector: (_, control) => control.sportJacks,
            builder: (_, jacks, __) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final jack = jacks[index];
                    return JackCard(
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
      ],
    );
  }
}
