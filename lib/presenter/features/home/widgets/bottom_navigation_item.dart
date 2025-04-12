import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/text_theme/colors.dart';

// ignore: must_be_immutable
class JackNavbarItem extends StatefulWidget {
  const JackNavbarItem({
    required this.label,
    required this.onTap,
    required this.svgIcon,
    required this.isSelected,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final String svgIcon;
  final bool isSelected;

  @override
  State<JackNavbarItem> createState() => _JackNavbarItemState();
}

class _JackNavbarItemState extends State<JackNavbarItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: widget.isSelected
            ? ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Item(widget: widget))
            : Item(widget: widget));
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.widget,
  });

  final JackNavbarItem widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          widget.svgIcon,
          height: Responsive.getHeightValue(23),
        ),
        SizedBox(
          height: Responsive.getHeightValue(5),
        ),
        Text(widget.label,
            style: JackFontStyle.verySmall.copyWith(color: mediumGrey)),
      ],
    );
  }
}

class CentralJackNavbarItem extends StatefulWidget {
  const CentralJackNavbarItem({
    required this.onTap,
    required this.svgIcon,
    super.key,
  });

  final VoidCallback onTap;
  final String svgIcon;

  @override
  State<CentralJackNavbarItem> createState() => _CentralJackNavbarItemState();
}

class _CentralJackNavbarItemState extends State<CentralJackNavbarItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: Responsive.getHeightValue(66),
                width: Responsive.getHeightValue(66),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: primaryGradient,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: -5,
              child: SvgPicture.asset(
                widget.svgIcon,
                height: Responsive.getHeightValue(60),
              ),
            ),
          ],
        ));
  }
}
