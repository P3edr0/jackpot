import 'package:jackpot/shared/utils/formatters/regx.dart';

class PasswordValidator {
  String? call(String value) {
    {
      final handledValue = value.trim();
      if (handledValue.length < 6) {
        return 'A senha precisa ter 6 ou mais caracteres';
      }
      if (!JackRegex.onlyNumbers.hasMatch(handledValue)) {
        return 'A senha precisa conter apenas números';
      }

      return null;
    }
  }
}
