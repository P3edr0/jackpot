import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';
import 'package:jackpot/theme/colors.dart';

class BetResumeCard extends StatelessWidget {
  const BetResumeCard({
    required this.couponId,
    required this.createdAt,
    required this.awards,
    required this.status,
    required this.onTap,
    super.key,
  });

  final String couponId;
  final List<String> awards;
  final String createdAt;
  final BetStatus status;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final handledCreateAt =
        createdAt.trim().isEmpty ? '- - / - - / - -' : createdAt;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.getHeightValue(16)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: lightGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              width: Responsive.getHeightValue(200),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: status.getLabelColor()),
              child: Text(
                status.getTitle(),
                style: JackFontStyle.smallBold.copyWith(color: secondaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, left: 16, right: 2, bottom: 16),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prêmios:',
                        style: JackFontStyle.bodyLargeBold
                            .copyWith(color: darkBlue),
                      ),
                      SizedBox(
                        height: Responsive.getHeightValue(10),
                      ),
                      Text('Bicicleta elétrica', style: JackFontStyle.body),
                      const Text(
                        '',
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Nº do cupom',
                        style: JackFontStyle.verySmallBold,
                      ),
                      Text(couponId, style: JackFontStyle.h3Bold),
                      Text(
                        handledCreateAt,
                        style: JackFontStyle.verySmallBold,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Responsive.getHeightValue(8),
                  ),
                  Icon(Icons.chevron_right_outlined,
                      color: mediumGrey, size: Responsive.getHeightValue(30))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
