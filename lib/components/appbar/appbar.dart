import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class JackAppBar extends StatelessWidget {
  const JackAppBar({
    super.key,
    required this.title,
    this.alignment = MainAxisAlignment.spaceBetween,
  }) : isTransparent = false;
  const JackAppBar.transparent({
    super.key,
    required this.title,
    this.alignment = MainAxisAlignment.start,
  }) : isTransparent = true;

  final String? title;
  final MainAxisAlignment alignment;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    final bool hasTitle = title != null;
    if (isTransparent) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(color: transparent),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: JackCircularButton(
                  onTap: () => Navigator.pop(context),
                  size: 50,
                  child: const Icon(
                    Icons.arrow_back,
                    color: secondaryColor,
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            if (hasTitle)
              Text(
                title!,
                style: JackFontStyle.title.copyWith(color: secondaryColor),
              ),
          ],
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: Responsive.getHeightValue(80),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(gradient: primaryGradient, boxShadow: [
        BoxShadow(
            color: darkBlue.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 0.8,
            spreadRadius: 0.8)
      ]),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: JackCircularButton(
                onTap: () => Navigator.pop(context),
                size: 50,
                child: const Icon(
                  Icons.arrow_back,
                  color: secondaryColor,
                )),
          ),
          if (hasTitle)
            Text(
              title!,
              style: JackFontStyle.titleBold.copyWith(color: secondaryColor),
            ),
          const SizedBox(
            width: 50,
          )
        ],
      ),
    );
  }
}
