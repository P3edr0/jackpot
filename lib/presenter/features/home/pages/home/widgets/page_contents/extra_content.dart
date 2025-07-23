import 'package:flutter/material.dart';
import 'package:jackpot/components/cards/jack_card.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/presenter/features/extra_jackpot/extra_jackpot_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/states_filter.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
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
        Selector<HomeController, List<ResumeJackpotEntity>>(
            selector: (_, control) => control.extraJacks,
            builder: (_, jacks, __) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final jack = jacks[index];
                    return JackCard(
                      onTap: () {
                        final extraJackController =
                            Provider.of<ExtraJackpotController>(context,
                                listen: false);
                        extraJackController.setSelectedJackpotDetails(
                            newId: jack.jackpotId.toString(),
                            image: jack.banner,
                            label: jack.title);
                        Navigator.pushNamed(
                            context, AppRoutes.extraCouponSelect);
                      },
                      title: jack.title,
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
