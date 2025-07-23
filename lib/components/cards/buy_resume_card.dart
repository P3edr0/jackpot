import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/theme/colors.dart';

class BuyResumeCard extends StatelessWidget {
  const BuyResumeCard({
    required this.couponsQuantity,
    required this.totalValue,
    super.key,
  }) : isSmall = false;
  const BuyResumeCard.small({
    required this.couponsQuantity,
    required this.totalValue,
    super.key,
  }) : isSmall = true;
  final bool isSmall;
  final int couponsQuantity;
  final double totalValue;
  @override
  Widget build(BuildContext context) {
    final totalValueFontStyle = isSmall
        ? JackFontStyle.titleBold.copyWith(color: secondaryColor)
        : JackFontStyle.h3Bold.copyWith(color: secondaryColor);
    final double paddingSize = isSmall ? 8 : 16;
    final couponFontStyle =
        JackFontStyle.h3Bold.copyWith(color: secondaryColor);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), gradient: secondaryGradient),
      padding: EdgeInsets.all(paddingSize),
      child: Row(
        children: [
          if (isSmall)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qtde.\nCupons',
                  style: JackFontStyle.small.copyWith(color: secondaryColor),
                ),
                SizedBox(
                  width: Responsive.getHeightValue(10),
                ),
                Text('$couponsQuantity', style: couponFontStyle),
              ],
            ),
          if (!isSmall)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qtde. Cupons',
                  style: JackFontStyle.small.copyWith(color: secondaryColor),
                ),
                SizedBox(
                  height: Responsive.getHeightValue(10),
                ),
                Text('$couponsQuantity', style: couponFontStyle),
              ],
            ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total',
                style: JackFontStyle.small.copyWith(color: secondaryColor),
              ),
              if (!isSmall)
                SizedBox(
                  height: Responsive.getHeightValue(10),
                ),
              Text(MoneyFormat.toReal(totalValue.toString()),
                  style: totalValueFontStyle),
            ],
          )
        ],
      ),
    );
  }
}
