import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as im;
import 'package:jackpot/domain/entities/compress_object_entity.dart';
import 'package:jackpot/domain/entities/face_detector_view_model.dart';
import 'package:jackpot/domain/exceptions/face_exception.dart';
import 'package:jackpot/domain/exceptions/face_exception_type_extension.dart';
import 'package:jackpot/shared/utils/enums/face_exceptions_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceCaptureController extends ChangeNotifier {
  FaceCaptureController();
  /////////////////////////// VARS ////////////////////////////////////
  final faceDetector =
      FaceDetector(options: FaceDetectorOptions(minFaceSize: 1));
  File? _file;
  bool _hasValidPhoto = false;
  Timer? timer;
  String? exception;
  String? _base64Image;
  bool _loading = false;
  FaceDetectorViewModel? _viewModel;
  CameraController? _cameraController;
  int _percentFallback = 0;

  /////////////////////////// GETS ////////////////////////////////////

  bool get hasError => exception != null;
  bool get loading => _loading;
  File? get file => _file;
  bool get hasValidPhoto => _hasValidPhoto;
  FaceDetectorViewModel? get viewModel => _viewModel;
  CameraController? get cameraController => _cameraController;
  String? get base64Image => _base64Image;
  /////////////////////////// FUNCTIONS ////////////////////////////////////

  Future<String> _compressBase64Image() async {
    return base64Encode((await FlutterImageCompress.compressWithFile(file!.path,
        quality: 30, format: CompressFormat.jpeg))!);
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

  Future<void> readCameraImage() async {
    log("Entrou no read camera");

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_viewModel!.duration.inSeconds > 0) {
        _viewModel!.duration -= const Duration(seconds: 1);
        log(_viewModel!.duration.toString(), name: "Duração");
        notifyListeners();
      }
    });
    await Future.delayed(const Duration(seconds: 3));
    _viewModel!.duration = const Duration(seconds: 3);

    timer!.cancel();
    setViewModel(FaceDetectorViewModel(
      'Scaneando seu rosto, fique parado e alinhado com a câmera.',
      icon: Icons.fullscreen,
      isLoading: false,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ));
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    await onClickCamera();
    if (!hasValidPhoto) await readCameraImage();
  }

  Future<void> onClickCamera() async {
    try {
      if (cameraController == null) return;

      final XFile camera = await cameraController!.takePicture();
      Object? error;

      do {
        try {
          final tempFile = await getCompressedImage(camera);
          final face = await getFaceFile(tempFile);

          final kb = face.lengthSync() / 1024;

          if (kb.toInt() > 200) {
            _percentFallback += 10;
            throw Exception("Image size > 200 KB: ${kb.toInt()}");
          }

          setFile(face);
          _hasValidPhoto = true;
          if (error != null) error = null;
          timer!.cancel();
          notifyListeners();
          // Navigator.pushNamed(context, AppRoutes.previewCapturedFace);
        } on FaceException {
          rethrow;
        } catch (e) {
          error = e;
        }
      } while (!hasValidPhoto && _percentFallback < 70);

      if (error != null) throw error;
    } on FaceException catch (e) {
      setViewModel(FaceDetectorViewModel(
        e.toString(),
        icon: e.type.icon,
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
      ));
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      setViewModel(FaceDetectorViewModel(
        'Erro desconhecido ao realizar leitura facial',
        icon: Icons.error,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ));
    }
  }

  Future<void> onInitFaceDetector() async {
    await Permission.camera.request();
    final cameras = await availableCameras();
    setCameraController(CameraController(
        cameras.firstWhere((e) => e.lensDirection == CameraLensDirection.front),
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888));
    await cameraController!.initialize();
    await cameraController!.setFocusMode(FocusMode.auto);
    await readCameraImage();
  }

  Future<File> getFaceFile(File file) async {
    final inputImage = InputImage.fromFilePath(file.path);

    await _getFace(inputImage);
    return File(file.path);
  }

  Future<Face> _getFace(InputImage inputImage) async {
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (faces.isEmpty) throw FaceException(FaceExceptionType.noFace);
    if (faces.length > 1) throw Exception(FaceExceptionType.multipleFaces);
    final face = validFace(faces.first);
    return face;
  }

  Face validFace(Face face) {
    final such = Platform.isIOS ? 485 : 500;
    final min = Platform.isIOS ? 1136 : 1170;

    if (face.boundingBox.height < such) {
      throw FaceException(FaceExceptionType.suchDistance, face: face);
    }

    if (face.boundingBox.height > min) {
      throw FaceException(FaceExceptionType.minDistance, face: face);
    }

    if (face.headEulerAngleX == null ||
        face.headEulerAngleY == null ||
        face.headEulerAngleZ == null) {
      throw FaceException(FaceExceptionType.cantReadValues, face: face);
    }
    if (face.headEulerAngleZ! > 15 || face.headEulerAngleZ! < -15) {
      throw FaceException(FaceExceptionType.turned, face: face);
    }
    if (face.headEulerAngleX! > 25 || face.headEulerAngleX! < -25) {
      throw FaceException(FaceExceptionType.vertical, face: face);
    }
    if (face.headEulerAngleY! > 15 || face.headEulerAngleY! < -15) {
      throw FaceException(FaceExceptionType.horizontal, face: face);
    }

    if (face.leftEyeOpenProbability != null &&
        face.rightEyeOpenProbability != null) {
      if (face.leftEyeOpenProbability! < 0.3 &&
          face.rightEyeOpenProbability! < 0.3) {
        throw FaceException(FaceExceptionType.closedEyes, face: face);
      }
    }
    return face;
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

  /////////////////////////// SETS ////////////////////////////////////
  void setLoading([bool? newLoading]) {
    if (newLoading == null) {
      _loading = !loading;
      notifyListeners();
    } else {
      if (_loading == newLoading) return;
      _loading = newLoading;
      notifyListeners();
    }
  }

  Future<void> setFile(File? newFile) async {
    _file = newFile;
    _base64Image = await _compressBase64Image();

    notifyListeners();
  }

  setViewModel(FaceDetectorViewModel newViewModel) {
    _viewModel = newViewModel;
    notifyListeners();
  }

  setViewModelDuration(Duration newDuration) {
    _viewModel!.duration = newDuration;
    notifyListeners();
  }

  setCameraController(CameraController newCameraController) {
    _cameraController = newCameraController;
    notifyListeners();
  }
}
