import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/pages/home/widgets/sports_filter/filter_item.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/sports.dart';
import 'package:provider/provider.dart';

class SportsFilter extends StatelessWidget {
  const SportsFilter({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) => SizedBox(
          width: constraints.maxWidth,
          height: Responsive.getHeightValue(75),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: SportsOptions.values.map((sport) {
                final iconName = sport.name;
                final iconLabel = sport.translateName();
                if (controller.selectedSport.name == sport.name) {
                  return FilterItem(
                    iconName: iconName,
                    label: iconLabel,
                    isSelected: true,
                    onTap: () {},
                  );
                } else {
                  return FilterItem(
                    iconName: iconName,
                    label: iconLabel,
                    onTap: () {
                      controller.setSelectedSport(sport);
                    },
                    isSelected: false,
                  );
                }
              }).toList(),
            ),
          )),
    );
  }
}
