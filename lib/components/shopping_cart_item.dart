import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';

class JackCartIcon extends StatelessWidget {
  const JackCartIcon({
    super.key,
    required this.itemCount,
    required this.onTap,
    this.havePadding = true,
  });
  final int itemCount;
  final VoidCallback onTap;
  final bool havePadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(Responsive.getHeightValue(havePadding ? 6 : 0)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              AppAssets.shoppingCartSvg,
              semanticsLabel: 'Shopping Cart',
              height: Responsive.getHeightValue(24),
            ),
            if (itemCount > 0)
              Positioned(
                left: 12,
                top: -9,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
