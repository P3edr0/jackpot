import 'dart:convert';
import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/image.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/formatters/date_formatter.dart';
import 'package:jackpot/theme/colors.dart';

class AwardsCard extends StatelessWidget {
  const AwardsCard({
    super.key,
    required this.onTap,
    required this.constraints,
    required this.awards,
    required this.title,
    required this.date,
    required this.homeTeam,
    required this.visitTeam,
    required this.setFavorite,
    required this.isFavorite,
  });
  final BoxConstraints constraints;
  final List<AwardEntity> awards;
  final String title;
  final TeamEntity homeTeam;
  final TeamEntity visitTeam;
  final DateTime date;
  final bool isFavorite;

  final VoidCallback setFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (awards.isEmpty) {
      return const SizedBox.shrink();
    }
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
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: lightGrey),
                      color: transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: Responsive.getHeightValue(8),
                      ),
                      SizedBox(
                        height: Responsive.getHeightValue(200),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                List<Widget>.generate(awards.length, (index) {
                              final award = awards[index];
                              Uint8List? bannerBytes;
                              try {
                                bannerBytes = base64Decode(award.image);
                              } catch (e) {
                                bannerBytes = null;
                              }
                              if (bannerBytes != null) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: lightGrey),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      padding: EdgeInsets.all(
                                          Responsive.getHeightValue(8)),
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              Responsive.getHeightValue(4)),
                                      child: Row(
                                        children: [
                                          SizedBox.square(
                                            dimension:
                                                Responsive.getHeightValue(40),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                bannerBytes,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    SizedBox.square(
                                                  dimension:
                                                      Responsive.getHeightValue(
                                                          40),
                                                  child: Image.asset(
                                                      AppAssets.splash),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            award.name,
                                            style: JackFontStyle.bodyLargeBold
                                                .copyWith(color: mediumGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox.square(
                                  dimension: Responsive.getHeightValue(40),
                                  child: Image.asset(AppAssets.splash),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Responsive.getHeightValue(10),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            JackImage(
                              image: homeTeam.logo,
                              height: 40,
                            ),
                            SizedBox(
                              width: Responsive.getHeightValue(5),
                            ),
                            Text(
                              'X',
                              style: JackFontStyle.bodyLargeBold
                                  .copyWith(color: mediumGrey),
                            ),
                            SizedBox(
                              width: Responsive.getHeightValue(5),
                            ),
                            JackImage(
                              image: visitTeam.logo,
                              height: 40,
                            ),
                            const Spacer(),
                            Text(JackDateFormat.eventTimeFormat(date),
                                style: JackFontStyle.small.copyWith(
                                    color: mediumGrey,
                                    fontWeight: FontWeight.w900)),
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
        ],
      ),
    );
  }

  String handledPotValue(String potValue) {
    return int.parse(potValue).obterReal();
  }
}
