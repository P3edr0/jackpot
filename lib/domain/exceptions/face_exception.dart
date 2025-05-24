import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:jackpot/domain/exceptions/face_exception_type_extension.dart';
import 'package:jackpot/shared/utils/enums/face_exceptions_type.dart';

class FaceException implements Exception {
  final FaceExceptionType type;
  final Face? face;

  FaceException(this.type, {this.face});

  @override
  String toString() {
    return type.label;
  }
}
