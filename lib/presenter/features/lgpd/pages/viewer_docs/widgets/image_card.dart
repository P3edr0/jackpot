import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/outline_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
      {super.key,
      required this.image,
      required this.name,
      required this.document});
  final String image;
  final String name;
  final String document;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: darkBlue,
          radius: Responsive.getHeightValue(62),
          child: CircleAvatar(
              radius: Responsive.getHeightValue(60),
              backgroundImage: NetworkImage(image)),
        ),
        SizedBox(
          width: Responsive.getHeightValue(10),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      textAlign: TextAlign.start,
                      style: JackFontStyle.bodyLargeBold.copyWith(
                          color: darkBlue, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.getHeightValue(10),
              ),
              Text(
                document,
                textAlign: TextAlign.left,
                style: JackFontStyle.bodyLarge
                    .copyWith(color: mediumGrey, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: Responsive.getHeightValue(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  JackOutlineButton(
                      width: Responsive.getHeightValue(100),
                      height: Responsive.getHeightValue(50),
                      borderColor: alertColor,
                      child: Text(
                        "Sair",
                        textAlign: TextAlign.left,
                        style: JackFontStyle.bodyLarge.copyWith(
                            color: alertColor, fontWeight: FontWeight.w900),
                      ),
                      onTap: () {}),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
