import 'package:flutter/material.dart';
import 'package:jackpot/presenter/features/home/store/home_controller.dart';
import 'package:jackpot/presenter/features/home/widgets/sports_filter/filter_item.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/utils/enums/sports.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SportsOptions.values.map((sport) {
              final iconName = sport.name;
              final iconLabel = sport.translateName();
              if (sport.isSoccer) {
                return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 16),
                    child: FilterItem(
                      iconName: iconName,
                      label: iconLabel,
                      isSelected: true,
                    ));
              } else {
                return Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: FilterItem(
                      iconName: iconName,
                      label: iconLabel,
                      isSelected: false,
                    ));
              }
            }).toList(),
          )),
    );
  }
}
