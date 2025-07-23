import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/theme/colors.dart';

class JackAppBarSecondary extends StatelessWidget {
  const JackAppBarSecondary(
      {super.key,
      this.alignment = MainAxisAlignment.spaceBetween,
      this.isTransparent = false,
      required this.child});

  final MainAxisAlignment alignment;
  final Widget child;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration:
          BoxDecoration(gradient: isTransparent ? null : primaryGradient),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          JackCircularButton(
              onTap: () => Navigator.pop(context),
              size: 50,
              child: const Icon(
                Icons.arrow_back,
                color: secondaryColor,
              )),
          const SizedBox(
            width: 10,
          ),
          child
        ],
      ),
    );
  }
}
