import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

class SelectableRoundedButton extends StatefulWidget {
  const SelectableRoundedButton(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.label});
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  @override
  State<SelectableRoundedButton> createState() =>
      _SelectableRoundedButtonState();
}

class _SelectableRoundedButtonState extends State<SelectableRoundedButton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSelected) {
      return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
          child: JackOutlineButton(
              onTap: widget.onTap,
              child: Text(
                widget.label,
                style: JackFontStyle.body,
              )));
    }
    return JackRoundedButton(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: JackFontStyle.body.copyWith(color: secondaryColor),
        ));
  }
}
