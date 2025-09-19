import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/components/image.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/formatters/date_formatter.dart';
import 'package:jackpot/theme/colors.dart';

class MatchCardCarousel extends StatefulWidget {
  const MatchCardCarousel({
    super.key,
    required this.constraints,
    required this.jackpots,
  });
  final BoxConstraints constraints;

  final List<SportJackpotEntity> jackpots;

  @override
  State<MatchCardCarousel> createState() => _MatchCardCarouselState();
}

class _MatchCardCarouselState extends State<MatchCardCarousel> {
  bool canNextCard = true;
  bool canBackCard = false;
  int currentCard = 0;

  void verifyStatus() {
    if (currentCard < widget.jackpots.length - 1) {
      canNextCard = true;
    } else {
      canNextCard = false;
    }
    if (currentCard > 0) {
      canBackCard = true;
    } else {
      canBackCard = false;
    }
    setState(() {});
  }

  nextCard() {
    if (canNextCard) {
      setState(() {
        currentCard += 1;
      });
      verifyStatus();
    }
  }

  backCard() {
    if (canBackCard) {
      setState(() {
        currentCard -= 1;
      });
      verifyStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: transparent,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            width: widget.constraints.maxWidth,
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
                  width: widget.constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          JackDateFormat.eventTimeFormat(
                              widget.jackpots[currentCard].matchTime),
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
                                  image: widget
                                      .jackpots[currentCard].homeTeam.logo,
                                  height: 60,
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(6),
                                ),
                                Text(
                                  widget.jackpots[currentCard].homeTeam.name,
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
                                  image: widget
                                      .jackpots[currentCard].visitorTeam.logo,
                                  height: 60,
                                ),
                                SizedBox(
                                  height: Responsive.getHeightValue(6),
                                ),
                                Text(
                                  widget.jackpots[currentCard].visitorTeam.name,
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
                  widget.jackpots[currentCard].championship.name,
                  style: JackFontStyle.small.copyWith(
                      color: secondaryColor, fontWeight: FontWeight.w900),
                )),
          ),
        ],
      ),
      if (widget.jackpots.length > 1)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: backCard,
                      child: Icon(
                        Icons.arrow_left,
                        size: 50,
                        color: canBackCard ? darkBlue : lightGrey,
                      ),
                    ),
                    Text(
                      'Jackpots ${currentCard + 1}/${widget.jackpots.length}',
                      style: JackFontStyle.body.copyWith(
                          color: darkBlue, fontWeight: FontWeight.w900),
                    ),
                    InkWell(
                      onTap: nextCard,
                      child: Icon(
                        Icons.arrow_right,
                        size: 50,
                        color: canNextCard ? darkBlue : lightGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_right_outlined,
                  color: secondaryColor,
                )
              ],
            ),
          ],
        )
    ]);
  }
}
