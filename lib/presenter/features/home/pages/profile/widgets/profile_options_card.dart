import 'package:flutter/material.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/theme/colors.dart';

class ProfileOptionsCard extends StatelessWidget {
  const ProfileOptionsCard({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: Responsive.getHeightValue(80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondaryColor,
            boxShadow: const [
              BoxShadow(
                  color: mediumGrey,
                  offset: Offset(0, 1),
                  blurRadius: 0.5,
                  spreadRadius: 0.5)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Icon(
                icon,
                color: darkBlue,
                size: Responsive.getHeightValue(32),
              ),
            ),
            SizedBox(width: Responsive.getHeightValue(10)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: JackFontStyle.bodyLargeBold
                        .copyWith(color: black, fontWeight: FontWeight.w900),
                  ),
                  if (subtitle != null) Text(subtitle!)
                ])
          ],
        ),
      ),
    );
  }
}
