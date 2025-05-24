import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';

import '../../theme/colors.dart';

class JackSelectableRoundedButton extends StatefulWidget {
  const JackSelectableRoundedButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.label,
    this.child,
    this.height = 32,
    this.width,
    this.radius = 30,
    this.withShader = true,
    this.borderColor = mediumGrey,
    this.borderWidth = 1,
  });
  final bool isSelected;
  final bool withShader;
  final VoidCallback? onTap;
  final String? label;
  final double? width;
  final double height;
  final double radius;
  final Widget? child;
  final Color borderColor;
  final double borderWidth;
  @override
  State<JackSelectableRoundedButton> createState() =>
      _JackSelectableRoundedButtonState();
}

class _JackSelectableRoundedButtonState
    extends State<JackSelectableRoundedButton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSelected && widget.withShader) {
      Widget? handledChild = widget.label == null
          ? widget.child
          : Text(
              widget.label!,
              style: JackFontStyle.body.copyWith(color: widget.borderColor),
            );
      return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
          child: JackOutlineButton(
              radius: widget.radius,
              borderWidth: widget.borderWidth,
              height: widget.height,
              width: widget.width,
              onTap: widget.onTap,
              child: handledChild!));
    }

    if (!widget.isSelected && !widget.withShader) {
      Widget? handledChild = widget.label == null
          ? widget.child
          : Text(
              widget.label!,
              style: JackFontStyle.body.copyWith(color: widget.borderColor),
            );
      return JackOutlineButton(
          radius: widget.radius,
          height: widget.height,
          width: widget.width,
          onTap: widget.onTap,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          child: handledChild!);
    }
    Widget? handledChild = widget.label == null
        ? widget.child
        : Text(
            widget.label!,
            style: JackFontStyle.bodyBold.copyWith(color: secondaryColor),
          );

    return JackRoundedButton(
      radius: widget.radius,
      height: widget.height,
      width: widget.width,
      onTap: widget.onTap,
      child: handledChild!,
    );
  }
}
