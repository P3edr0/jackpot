import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

class JackCard extends StatelessWidget {
  const JackCard(
      {super.key,
      required this.constraints,
      required this.image,
      required this.potValue,
      required this.setFavorite,
      required this.isFavorite});
  final BoxConstraints constraints;
  final String image;
  final String potValue;
  final VoidCallback setFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(
        Responsive.getHeightValue(8),
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: lightGrey),
          color: transparent,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      width: constraints.maxWidth,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.memory(base64.decode(image))),
              Positioned(
                  top: 8,
                  right: 8,
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
          SizedBox(
            height: Responsive.getHeightValue(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bolada no seu bolso',
                style: JackFontStyle.bodyLarge
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              JackRoundedButton(
                  onTap: () {},
                  child: Text(
                    'Pote de R\$ $potValue,00',
                    style: JackFontStyle.bodyLarge.copyWith(
                        color: secondaryColor, fontWeight: FontWeight.w900),
                  )),
            ],
          ),
          SizedBox(
            height: Responsive.getHeightValue(12),
          ),
        ],
      ),
    );
  }
}
