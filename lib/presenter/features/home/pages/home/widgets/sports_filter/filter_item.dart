import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

import '../../../../../../../../shared/utils/app_assets.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.iconName,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconName;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final buttonColor = isSelected ? primaryFocusColor : gradientFocusColor;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: buttonColor,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: SvgPicture.asset(
                '${AppAssets.iconsPath}$iconName.svg',
                semanticsLabel: iconName,
                height: Responsive.getHeightValue(24),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.getHeightValue(5),
          ),
          Text(
            label,
            style: JackFontStyle.body,
          )
        ],
      ),
    );
  }
}
