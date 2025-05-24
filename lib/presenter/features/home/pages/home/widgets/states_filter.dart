import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/presenter/features/home/pages/home/store/home_controller.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:provider/provider.dart';

class StatesFilter extends StatelessWidget {
  const StatesFilter({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) => SizedBox(
        width: constraints.maxWidth,
        height: Responsive.getHeightValue(30),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.selectedStates.length + 1,
            itemBuilder: (context, index) {
              final hasSelected = controller.selectedStates.contains(true);
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 16),
                  child: JackSelectableRoundedButton(
                      isSelected: !hasSelected,
                      onTap: () => controller.clearSelectedState(),
                      label: 'Todos'),
                );
              } else {
                final selected = controller.selectedStates[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: JackSelectableRoundedButton(
                    isSelected: selected,
                    onTap: () => controller.setSelectedState(index - 1),
                    label: controller.states[index - 1],
                  ),
                );
              }
            }),
      ),
    );
  }
}
