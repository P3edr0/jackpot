import 'dart:convert';
import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/date_formatter.dart';
import 'package:jackpot/theme/colors.dart';

class ChampionshipJackCard extends StatelessWidget {
  const ChampionshipJackCard({
    super.key,
    required this.onTap,
    required this.constraints,
    required this.image,
    required this.title,
    required this.date,
    required this.homeTeam,
    required this.visitTeam,
    required this.setFavorite,
    required this.isFavorite,
  });
  final BoxConstraints constraints;
  final String image;
  final String title;
  final TeamEntity homeTeam;
  final TeamEntity visitTeam;
  final DateTime date;
  final bool isFavorite;

  final VoidCallback setFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Uint8List bannerBytes = base64Decode(image);
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          bannerBytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: Responsive.getHeightValue(10),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              homeTeam.logo,
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
                            Image.network(
                              visitTeam.logo,
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
          Positioned(
              top: 34,
              right: 14,
              child: InkWell(
                onTap: setFavorite,
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: secondaryColor,
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            size: Responsive.getHeightValue(30),
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            size: Responsive.getHeightValue(30),
                          )),
              )),
        ],
      ),
    );
  }

  String handledPotValue(String potValue) {
    return int.parse(potValue).obterReal();
  }
}
