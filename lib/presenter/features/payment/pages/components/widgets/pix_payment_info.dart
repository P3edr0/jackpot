import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/selectable_rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/formatters/money_formatters.dart';
import 'package:jackpot/theme/colors.dart';

class PixPaymentInfo extends StatelessWidget {
  const PixPaymentInfo({super.key, required this.totalValue});
  final double totalValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'PIX',
              style: JackFontStyle.bodyLargeBold.copyWith(color: darkBlue),
            ),
            SizedBox(
              width: Responsive.getHeightValue(5),
            ),
            const Icon(
              Icons.pix,
              color: pixColor,
            ),
            SizedBox(
              width: Responsive.getHeightValue(16),
            ),
            JackSelectableRoundedButton(
                padding: 10,
                withShader: true,
                radius: 30,
                isSelected: true,
                borderColor: darkBlue,
                borderWidth: 2,
                onTap: () async {},
                child: Text(
                  'Aprovação em minutos',
                  style: JackFontStyle.small.copyWith(color: secondaryColor),
                )),
          ],
        ),
        SizedBox(
          height: Responsive.getHeightValue(20),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('TOTAL - ${MoneyFormat.toReal(totalValue.toString())}',
              style: JackFontStyle.titleBold.copyWith(color: darkBlue)),
        ),
        SizedBox(
          height: Responsive.getHeightValue(20),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            AppAssets.pagSeguro,
            height: 20,
          ),
        )
      ],
    );
  }
}
