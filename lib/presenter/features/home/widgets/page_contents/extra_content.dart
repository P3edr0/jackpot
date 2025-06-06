import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/widgets/jack_card.dart';
import 'package:jackpot/presenter/features/home/widgets/states_filter.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:provider/provider.dart';

class ExtraContent extends StatelessWidget {
  const ExtraContent({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);

    return Column(
      children: [
        StatesFilter(
          constraints: constraints,
        ),
        SizedBox(
          height: Responsive.getHeightValue(30),
        ),
        Selector<HomeController, List<JackpotEntity>>(
            selector: (_, control) => control.extraJacks,
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
                          controller.setFavoriteExtraJacks(index),
                      isFavorite: jacks[index].isFavorite,
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
