import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 13) {
      text = text.substring(0, 13);
    }

    String newText;

    if (text.isEmpty) {
      newText = '+';
    } else if (text.length <= 2) {
      newText = '+$text';
    } else if (text.length <= 4) {
      newText = '+${text.substring(0, 2)} (${text.substring(2)}';
    } else if (text.length <= 8) {
      // Preenchendo até o DDD + início do número (4 digitos)
      newText =
          '+${text.substring(0, 2)} (${text.substring(2, 4)}) ${text.substring(4)}';
    } else if (text.length <= 12) {
      // Número completo: se tiver 8 ou 9 dígitos
      final numberPart = text.substring(4);
      if (numberPart.length <= 8) {
        // 8 dígitos
        newText = '+${text.substring(0, 2)} (${text.substring(2, 4)}) '
            '${numberPart.substring(0, 4)}-${numberPart.substring(4)}';
      } else {
        // 9 dígitos
        newText = '+${text.substring(0, 2)} (${text.substring(2, 4)}) '
            '${numberPart.substring(0, 5)}-${numberPart.substring(5)}';
      }
    } else {
      // No máximo 13 dígitos no total (DDI + DDD + 9 números)
      newText = '+${text.substring(0, 2)} (${text.substring(2, 4)}) '
          '${text.substring(4, 9)}-${text.substring(9, 13)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
