import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class JackCircularButton extends StatefulWidget {
  const JackCircularButton({
    required this.onTap,
    required this.size,
    required this.child,
    super.key,
  });

  final VoidCallback onTap;
  final double size;
  final Widget child;

  @override
  State<JackCircularButton> createState() => _JackCircularButtonState();
}

class _JackCircularButtonState extends State<JackCircularButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: Responsive.getHeightValue(widget.size),
          width: Responsive.getHeightValue(widget.size),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: primaryGradient,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
