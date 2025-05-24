import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.getHeightValue(40),
        width: Responsive.getHeightValue(40),
        child: Center(
          child: SizedBox(
              width: Responsive.getHeightValue(30),
              height: Responsive.getHeightValue(30),
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: color,
              )),
        ));
  }
}
