import 'package:flutter/widgets.dart';
import 'package:jackpot/theme/colors.dart';

enum BetStatus {
  closed,
  waitingAnswer,
  answered,
  awarded;

  bool get isClosed => this == closed;
  bool get isWaitingAnswer => this == waitingAnswer;
  bool get isAnswered => this == answered;
  bool get isAwarded => this == awarded;
  String getTitle() {
    switch (this) {
      case closed:
        return 'FINALIZADO';
      case waitingAnswer:
        return 'AGUARDANDO RESPOSTA';
      case answered:
        return 'RESPONDIDO';
      default:
        return 'PREMIADO';
    }
  }

  Color getLabelColor() {
    switch (this) {
      case closed:
        return alertColor;
      case waitingAnswer:
        return mediumGrey;
      case answered:
        return primaryColor;
      default:
        return gold;
    }
  }
}
