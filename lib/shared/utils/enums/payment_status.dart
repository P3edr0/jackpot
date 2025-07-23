import 'package:flutter/widgets.dart';
import 'package:jackpot/theme/colors.dart';

enum PaymentStatus {
  success,
  waiting,
  error;

  bool get isSuccess => this == success;
  bool get isWaiting => this == waiting;
  bool get isError => this == error;

  String getLabel() {
    switch (this) {
      case success:
        return 'Pagamento Confirmado';
      case waiting:
        return 'Aguardando Pagamento';
      default:
        return 'Falha ao identificar pagamento';
    }
  }

  Color getLabelColor() {
    switch (this) {
      case success:
        return primaryColor;
      case waiting:
        return warning.shade800;
      default:
        return alertColor.shade800;
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case success:
        return primaryColor.withValues(alpha: 0.3);
      case waiting:
        return warning.shade800.withValues(alpha: 0.3);
      default:
        return alertColor.shade800.withValues(alpha: 0.3);
    }
  }
}
