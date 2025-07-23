import 'package:flutter/material.dart';
import 'package:jackpot/components/loadings/loading_content.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/theme/colors.dart';

class JackCard extends StatelessWidget {
  const JackCard(
      {super.key,
      required this.onTap,
      required this.constraints,
      required this.image,
      required this.title,
      required this.potValue,
      required this.setFavorite,
      required this.isFavorite,
      this.margin = const EdgeInsets.symmetric(horizontal: 16)});
  final BoxConstraints constraints;
  final String image;
  final String title;
  final String potValue;
  final VoidCallback setFavorite;
  final bool isFavorite;
  final VoidCallback onTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final String handledTitle = title.isEmpty ? 'CONCORRA A PRÊMIOS' : title;
    return InkWell(
      onTap: onTap,
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
                    child: Image.network(image,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          final value =
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null;
                          return LoadingContent(value: value);
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(AppAssets.splash))),
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
                  handledTitle,
                  style: JackFontStyle.bodyLarge
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                // isLargeValue
                //     ? JackRoundedButton(
                //         height: 50,
                //         onTap: () {},
                //         child: Text(
                //           'Pote de\n ${MoneyFormat.toReal(potValue)}',
                //           style: JackFontStyle.bodyLarge.copyWith(
                //               color: secondaryColor,
                //               fontWeight: FontWeight.w900),
                //           textAlign: TextAlign.center,
                //         ))
                //     : JackRoundedButton(
                //         onTap: () {},
                //         child: Text(
                //           'Pote de R\$ ${MoneyFormat.toReal(potValue)}',
                //           style: JackFontStyle.bodyLarge.copyWith(
                //               color: secondaryColor,
                //               fontWeight: FontWeight.w900),
                //         )),
              ],
            ),
            SizedBox(
              height: Responsive.getHeightValue(12),
            ),
          ],
        ),
      ),
    );
  }
}
