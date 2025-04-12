import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

class JackRectangleButton extends StatelessWidget {
  const JackRectangleButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.isSelected = false});
  final VoidCallback onTap;
  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? gradientFocusColor : transparent;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: Responsive.getHeightValue(10)),
        height: Responsive.getHeightValue(32),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}
