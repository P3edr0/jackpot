import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jackpot/shared/utils/app_assets.dart';

class JackImage extends StatefulWidget {
  const JackImage({super.key, required this.image, this.height});
  final String image;
  final double? height;
  @override
  State<JackImage> createState() => _JackImageState();
}

class _JackImageState extends State<JackImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.image.startsWith('https://')) {
      return Image.network(
        widget.image,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset(AppAssets.splash, height: widget.height),
      );
    }

    return Image.memory(
      base64Decode(widget.image),
      height: widget.height,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(AppAssets.splash, height: widget.height),
    );
  }
}
