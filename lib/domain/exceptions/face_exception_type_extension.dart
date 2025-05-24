import 'package:flutter/material.dart';
import 'package:jackpot/shared/utils/enums/face_exceptions_type.dart';

extension FaceExceptionTypeExtension on FaceExceptionType {
  String get label {
    switch (this) {
      case FaceExceptionType.suchDistance:
        return 'A distância do rosto está muito longe da câmera';
      case FaceExceptionType.horizontal:
        return 'Seu rosto está horizontalmente desalinhado com a câmera.';
      case FaceExceptionType.vertical:
        return 'Seu rosto está vertical desalinhado com a câmera.';
      case FaceExceptionType.turned:
        return 'Seu rosto está muito virado de forma incorreta';
      case FaceExceptionType.brightness:
        return 'O local está muito escuro';
      case FaceExceptionType.noFace:
        return 'Nenhum rosto foi detectado';
      case FaceExceptionType.multipleFaces:
        return 'Mais de um rosto foi detectado';
      case FaceExceptionType.accessories:
        return 'Não conseguimos scanear rostos, certifique-se de que não há acessórios no rosto';
      case FaceExceptionType.unknown:
        return 'Erro desconhecido ao realizar leitura facial';
      case FaceExceptionType.cantReadValues:
        return 'Não foi possível ler os valores do rosto';
      case FaceExceptionType.closedEyes:
        return 'Seus olhos estão fechados';
      case FaceExceptionType.minDistance:
        return 'A distância do rosto está muito perto da câmera';
    }
  }

  IconData get icon {
    switch (this) {
      case FaceExceptionType.suchDistance:
        return Icons.face_unlock_outlined;
      case FaceExceptionType.horizontal:
        return Icons.horizontal_rule;
      case FaceExceptionType.vertical:
        return Icons.vertical_align_center;
      case FaceExceptionType.turned:
        return Icons.rotate_90_degrees_ccw;
      case FaceExceptionType.brightness:
        return Icons.brightness_5;
      case FaceExceptionType.noFace:
        return Icons.face;
      case FaceExceptionType.multipleFaces:
        return Icons.face_retouching_natural;
      case FaceExceptionType.accessories:
        return Icons.face_retouching_natural;
      case FaceExceptionType.unknown:
        return Icons.error;
      case FaceExceptionType.cantReadValues:
        return Icons.error;
      case FaceExceptionType.closedEyes:
        return Icons.remove_red_eye;
      case FaceExceptionType.minDistance:
        return Icons.face_unlock_outlined;
    }
  }
}
