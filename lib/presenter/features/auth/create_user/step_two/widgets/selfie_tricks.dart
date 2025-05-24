import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';

class SelfieTricks extends StatelessWidget {
  const SelfieTricks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox.square(
          dimension: Responsive.getHeightValue(80),
          child: Image.asset(
            AppAssets.selfieTrickOne,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox.square(
          dimension: Responsive.getHeightValue(80),
          child: Image.asset(
            AppAssets.selfieTrickTwo,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox.square(
          dimension: Responsive.getHeightValue(80),
          child: Image.asset(
            AppAssets.selfieTrickThree,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox.square(
          dimension: Responsive.getHeightValue(80),
          child: Image.asset(
            AppAssets.selfieTrickFour,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
