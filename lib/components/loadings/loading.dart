import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(gradient: secondaryGradient),
        child: Center(
          child: SizedBox(
              width: Responsive.getHeightValue(50),
              height: Responsive.getHeightValue(50),
              child: const CircularProgressIndicator(
                strokeWidth: 4,
              )),
        ));
  }
}
