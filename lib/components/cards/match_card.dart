import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/image.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/date_formatter.dart';
import 'package:jackpot/theme/colors.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.onTap,
    required this.constraints,
    required this.title,
    required this.potValue,
    required this.date,
    required this.homeTeam,
    required this.visitTeam,
  });
  final BoxConstraints constraints;
  final String title;
  final String potValue;
  final TeamEntity homeTeam;
  final TeamEntity visitTeam;
  final DateTime date;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                color: transparent,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            width: constraints.maxWidth,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: lightGrey),
                      color: transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(JackDateFormat.eventTimeFormat(date),
                          style: JackFontStyle.small.copyWith(
                              color: mediumGrey, fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: Responsive.getHeightValue(16),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                JackImage(
                                  image: homeTeam.logo,
                                  height: 60,
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(6),
                                ),
                                Text(
                                  homeTeam.name,
                                  style: JackFontStyle.small
                                      .copyWith(color: black),
                                ),
                              ],
                            ),
                            Text(
                              'X',
                              style: JackFontStyle.h2Bold
                                  .copyWith(color: mediumGrey),
                            ),
                            Column(
                              children: [
                                JackImage(
                                  image: visitTeam.logo,
                                  height: 60,
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(6),
                                ),
                                Text(
                                  visitTeam.name,
                                  style: JackFontStyle.small
                                      .copyWith(color: black),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 24,
            child: JackRoundedButton.solid(
                height: 24,
                onTap: () {},
                color: mediumDarkBlue,
                child: Text(
                  title,
                  style: JackFontStyle.small.copyWith(
                      color: secondaryColor, fontWeight: FontWeight.w900),
                )),
          ),
          // Positioned(
          //   bottom: 8,
          //   left: 24,
          //   child: JackRoundedButton(
          //       onTap: () {},
          //       child: Text(
          //         'Pote de ${MoneyFormat.toReal(potValue)}',
          //         style: JackFontStyle.bodyLarge.copyWith(
          //             color: secondaryColor, fontWeight: FontWeight.w900),
          //       )),
          // ),
        ],
      ),
    );
  }
}
