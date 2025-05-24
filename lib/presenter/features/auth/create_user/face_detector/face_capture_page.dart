import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:jackpot/domain/entities/face_detector_view_model.dart';
import 'package:jackpot/domain/exceptions/face_exception.dart';
import 'package:jackpot/domain/exceptions/face_exception_type_extension.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/components/face_detector_camera_widget.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/components/face_detector_scan_result_widget.dart';
import 'package:jackpot/presenter/features/auth/create_user/face_detector/store/face_capture_controller.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class FaceCapturePage extends StatefulWidget {
  const FaceCapturePage({super.key});

  @override
  State<FaceCapturePage> createState() => _FaceCapturePageState();
}

class _FaceCapturePageState extends State<FaceCapturePage> {
  CameraController? cameraController;
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  bool hasValidPhoto = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    final controller =
        Provider.of<FaceCaptureController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.setViewModel(FaceDetectorViewModel(
          'Inicializando modo de detecção de rosto, por favor aguarde...',
          icon: Icons.timer_outlined,
          isLoading: true));
      await onInitFaceDetector();
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Consumer<FaceCaptureController>(
        builder: (context, controller, child) => Scaffold(
            body: Stack(
          children: [
            FaceDetectorCameraWidget(
              viewModel: controller.viewModel!,
              cameraController: cameraController,
            ),
            FaceDetectorScanResultWidget(
              viewModel: controller.viewModel!,
              onCapture: () => onClickCamera(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> onInitFaceDetector() async {
    await Permission.camera.request();
    final cameras = await availableCameras();
    cameraController = CameraController(
        cameras.firstWhere((e) => e.lensDirection == CameraLensDirection.front),
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888);
    await cameraController!.initialize();
    await cameraController!.setFocusMode(FocusMode.auto);
    await readCameraImage();
  }

  Future<void> readCameraImage() async {
    final controller =
        Provider.of<FaceCaptureController>(context, listen: false);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (controller.viewModel!.duration.inSeconds > 0) {
        if (mounted) {
          final newDuration =
              controller.viewModel!.duration -= const Duration(seconds: 1);
          controller.setViewModelDuration(newDuration);
        }
      }
    });
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      controller.setViewModelDuration(const Duration(seconds: 3));
    }

    timer.cancel();
    setFaceState(FaceDetectorViewModel(
      'Scaneando seu rosto, fique parado e alinhado com a câmera.',
      icon: Icons.fullscreen,
      isLoading: false,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ));
    await Future.delayed(const Duration(seconds: 5));
    await onClickCamera();
    if (!hasValidPhoto) await readCameraImage();
  }

  int _percentFallback = 0;

  Future<void> onClickCamera() async {
    try {
      if (cameraController == null) return;

      final XFile camera = await cameraController!.takePicture();
      Object? error;

      do {
        try {
          log("Laço do while chamado");

          final file = await getCompressedImage(camera);
          final face =
              await Provider.of<FaceCaptureController>(context, listen: false)
                  .getFaceFile(file);

          final kb = face.lengthSync() / 1024;

          if (kb.toInt() > 200) {
            _percentFallback += 10;
            throw Exception("Image size > 200 KB: ${kb.toInt()}");
          }

          Provider.of<FaceCaptureController>(context, listen: false)
              .setFile(face);
          hasValidPhoto = true;
          if (error != null) error = null;
          cancelTimer();
          Navigator.pushNamed(context, AppRoutes.previewCapturedFace);
        } on FaceException {
          rethrow;
        } catch (e) {
          error = e;
        }
      } while (!hasValidPhoto && _percentFallback < 70);

      if (error != null) throw error;
    } on FaceException catch (e) {
      setFaceState(FaceDetectorViewModel(
        e.toString(),
        icon: e.type.icon,
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
      ));
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      setFaceState(FaceDetectorViewModel(
        'Erro desconhecido ao realizar leitura facial',
        icon: Icons.error,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ));
    }
  }

  void cancelTimer() {
    if (timer.isActive) timer.cancel();
  }

  Future<File> getCompressedImage(XFile image) async {
    final initialFile = File(image.path);
    final kb = initialFile.lengthSync() / 1024;

    if (kb <= 200) {
      return initialFile;
    }

    final tempDir = await getTemporaryDirectory();
    final rand = math.Random().nextInt(10000);
    CompressObject compressObject = CompressObject(
        imageFile: File(image.path),
        path: tempDir.path,
        rand: rand,
        expectedSize: Size(750 - ((750 * _percentFallback) / 100),
            1334 - ((1334 * _percentFallback) / 100)));
    String filePath = await _compressImage(compressObject);
    return File(filePath);
  }

  void setFaceState(FaceDetectorViewModel model) {
    if (mounted) {
      final controller =
          Provider.of<FaceCaptureController>(context, listen: false);
      controller.setViewModel(model);
    }
  }
}

class CompressObject {
  File imageFile;
  String path;
  int rand;
  Size expectedSize;

  CompressObject(
      {required this.imageFile,
      required this.path,
      required this.rand,
      required this.expectedSize});
}

/// https://stackoverflow.com/questions/73292337/flutter-google-ml-kit-plugin-facedetector-not-working-in-iphone-cameras
Future<String> _compressImage(CompressObject object) async {
  return compute(_decodeImage, object);
}

String _decodeImage(CompressObject object) {
  im.Image? image = im.decodeImage(object.imageFile.readAsBytesSync());

  im.Image smallerImage = im.copyResize(
      //https://www.appmysite.com/blog/the-complete-guide-to-iphone-screen-resolutions-and-sizes/
      // image!, width: 750, height: 1334
      image!,
      width: object.expectedSize.width.toInt(),
      height: object.expectedSize.height
          .toInt()); // choose the size here, it will maintain aspect ratio

  var decodedImageFile = File('${object.path}/img_${object.rand}.jpg');
  decodedImageFile.writeAsBytesSync(im.encodeJpg(smallerImage, quality: 85));

  return decodedImageFile.path;
}
