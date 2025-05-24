import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class StepByStep extends StatelessWidget {
  const StepByStep({super.key, required this.steps, required this.currentStep});
  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: steps,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _step(true);
          }

          if (index <= currentStep - 1) {
            return Row(
              children: [
                Container(
                  height: 1,
                  width: Responsive.getHeightValue(50),
                  color: mediumGrey,
                ),
                _step(true)
              ],
            );
          } else {
            return Row(
              children: [
                Container(
                  height: 1,
                  width: Responsive.getHeightValue(50),
                  color: mediumGrey,
                ),
                _step(false)
              ],
            );
          }
        });
  }

  Widget _step(bool isSelected) {
    if (isSelected) {
      return const CircleAvatar(
        backgroundColor: mediumGrey,
        radius: 15,
        child: CircleAvatar(
          backgroundColor: secondaryColor,
          radius: 14,
          child: CircleAvatar(
            radius: 5,
            backgroundColor: darkBlue,
          ),
        ),
      );
    }

    return const CircleAvatar(
        backgroundColor: mediumGrey,
        radius: 15,
        child: CircleAvatar(
          backgroundColor: secondaryColor,
          radius: 14,
        ));
  }
}
