import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class SelectablePaymentMethod extends StatelessWidget {
  const SelectablePaymentMethod(
      {super.key,
      required this.onTap,
      required this.isSelected,
      required this.label});

  final VoidCallback onTap;
  final bool isSelected;
  final String label;
  @override
  Widget build(BuildContext context) {
    return JackSelectableRoundedButton(
      height: 44,
      withShader: isSelected,
      radius: 8,
      isSelected: false,
      borderColor: mediumGrey,
      borderWidth: 2,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.circle_outlined,
            color: mediumGrey,
          ),
          SizedBox(
            width: Responsive.getHeightValue(5),
          ),
          Text(
            label,
            style: JackFontStyle.bodyLargeBold.copyWith(color: mediumGrey),
          )
        ],
      ),
    );
  }
}
