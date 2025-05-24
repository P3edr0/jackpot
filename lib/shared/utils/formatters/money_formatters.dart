import 'package:brasil_fields/brasil_fields.dart';

class MoneyFormat {
  static String toReal(String value) {
    final realValue = double.parse(value).obterReal();

    return realValue;
  }
}
