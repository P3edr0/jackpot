import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';

import '../../theme/colors.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key, this.value});
  final double? value;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: Responsive.getHeightValue(200),
        width: size.width,
        decoration: const BoxDecoration(gradient: secondaryGradient),
        child: Center(
          child: SizedBox(
              width: Responsive.getHeightValue(50),
              height: Responsive.getHeightValue(50),
              child: CircularProgressIndicator(
                strokeWidth: 4,
                value: value,
              )),
        ));
  }
}
