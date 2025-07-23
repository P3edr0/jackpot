import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/rounded_button.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/theme/colors.dart';

class ItemShoppingCart extends StatelessWidget {
  const ItemShoppingCart(
      {super.key,
      required this.onTap,
      required this.constraints,
      required this.image,
      required this.title,
      required this.couponsQuantity,
      required this.onTapRemove,
      this.margin = const EdgeInsets.symmetric(horizontal: 16)});
  final BoxConstraints constraints;
  final String image;
  final String title;
  final String couponsQuantity;
  final VoidCallback onTapRemove;
  final VoidCallback onTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(image);
    final String handledTitle = title.isEmpty ? 'CONCORRA A PRÊMIOS' : title;
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
            child: Container(
              margin: margin,
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
                        child: Image.memory(bytes,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppAssets.splash)),
                      ),
                      Positioned(
                          top: 8,
                          right: 8,
                          child: InkWell(
                            onTap: onTapRemove,
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: secondaryColor,
                                child: Icon(
                                  Icons.delete_outline,
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
                        handledTitle,
                        style: JackFontStyle.bodyLarge
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.getHeightValue(24),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Row(
              children: [
                const Spacer(),
                JackRoundedButton(
                    onTap: () {},
                    child: Text(
                      '$couponsQuantity Cupons',
                      style: JackFontStyle.bodyLarge.copyWith(
                          color: secondaryColor, fontWeight: FontWeight.w900),
                    )),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
