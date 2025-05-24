import 'package:flutter/material.dart';
import 'package:gradient_widgets_plus/gradient_widgets_plus.dart';
import 'package:jackpot/domain/entities/face_detector_view_model.dart';
import 'package:jackpot/theme/colors.dart';

class FaceDetectorScanResultWidget extends StatefulWidget {
  final FaceDetectorViewModel viewModel;
  final Future<void> Function() onCapture;

  const FaceDetectorScanResultWidget({
    required this.viewModel,
    required this.onCapture,
    super.key,
  });

  @override
  State<FaceDetectorScanResultWidget> createState() =>
      _FaceDetectorScanResultWidgetState();
}

class _FaceDetectorScanResultWidgetState
    extends State<FaceDetectorScanResultWidget> {
  bool isButtonLoading = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!widget.viewModel.isLoading)
            const SizedBox(
              width: double.maxFinite,
              height: 10,
              child: GradientProgressIndicator(
                gradient: secondaryGradient,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: widget.viewModel.backgroundColor,
            ),
            child: Row(
              children: [
                if (widget.viewModel.icon != null)
                  Icon(widget.viewModel.icon,
                      color: widget.viewModel.foregroundColor),
                const SizedBox(width: 24),
                Expanded(
                    child: Text(widget.viewModel.state,
                        style: TextStyle(
                          color: widget.viewModel.foregroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )))
              ],
            ),
          ),
          LinearProgressIndicator(
            value: widget.viewModel.duration.inSeconds / 4,
            backgroundColor: widget.viewModel.backgroundColor.withOpacity(0.4),
            valueColor: AlwaysStoppedAnimation(
                widget.viewModel.backgroundColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
