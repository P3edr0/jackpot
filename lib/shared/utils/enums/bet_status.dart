import 'package:flutter/widgets.dart';
import 'package:jackpot/theme/colors.dart';

enum BetStatus {
  closed,
  waitingAnswer,
  waitingPayment,
  answered,
  awarded;

  bool get isClosed => this == closed;
  bool get isWaitingAnswer => this == waitingAnswer;
  bool get isWaitingPayment => this == waitingPayment;
  bool get isAnswered => this == answered;
  bool get isAwarded => this == awarded;
  String getTitle() {
    switch (this) {
      case closed:
        return 'FINALIZADO';
      case waitingAnswer:
        return 'AGUARDANDO RESPOSTA';
      case waitingPayment:
        return 'AGUARDANDO PAGAMENTO';
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
      case waitingPayment:
        return bronze;
      case waitingAnswer:
        return mediumGrey;
      case answered:
        return primaryColor;
      default:
        return gold;
    }
  }

  static BetStatus translate(String value) {
    switch (value) {
      case 'closed':
        return BetStatus.closed;
      case 'waitingPayment':
        return BetStatus.waitingPayment;
      case 'waitingAnswer':
        return BetStatus.waitingAnswer;
      case 'answered':
        return BetStatus.answered;
      default:
        return BetStatus.awarded;
    }
  }
}
