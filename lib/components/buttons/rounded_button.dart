import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

class JackRoundedButton extends StatelessWidget {
  const JackRoundedButton(
      {super.key, required this.child, required this.onTap});
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: Responsive.getHeightValue(20)),
        height: Responsive.getHeightValue(32),
        decoration: BoxDecoration(
            gradient: primaryGradient, borderRadius: BorderRadius.circular(16)),
        child: child,
      ),
    );
  }
}
