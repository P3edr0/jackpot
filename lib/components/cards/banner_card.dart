import 'package:flutter/material.dart';
import 'package:jackpot/components/loadings/loading_content.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: Responsive.getHeightValue(150),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            image,
            height: Responsive.getHeightValue(150),
            width: size.width - 32,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              final value = loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null;
              return LoadingContent(value: value);
            },
            errorBuilder: (context, error, stackTrace) => Image.asset(
              AppAssets.splash,
              fit: BoxFit.cover,
              height: Responsive.getHeightValue(150),
              width: size.width - 32,
            ),
          )),
    );
  }
}
