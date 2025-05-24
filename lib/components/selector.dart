import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/theme/colors.dart';

class JackSelector extends StatelessWidget {
  const JackSelector(
      {super.key,
      required this.isSelected,
      required this.label,
      required this.onTap});
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: darkBlue,
            radius: 10,
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              radius: 8,
              child: CircleAvatar(
                backgroundColor: isSelected ? darkBlue : secondaryColor,
                radius: 5,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: JackFontStyle.bodyLarge.copyWith(
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
