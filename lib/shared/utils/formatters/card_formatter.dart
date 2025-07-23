import 'package:flutter/services.dart';
import 'package:jackpot/shared/utils/formatters/formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFormatter extends TextInputFormatter {
  final String separator;
  CardFormatter({this.separator = ' '});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(separator, '');
    var buffer = StringBuffer();
    if (newValue.text.length >= 19) {
      final value = newValue.text.substring(0, 19);
      return newValue.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final next = i + 1;
      if (next % 4 == 0 && next != text.length) {
        buffer.write(separator);
      }
    }

    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class DateCardFormatter extends Formatter {
  static final maskFormatter = MaskTextInputFormatter(
      mask: '##/####',
      filter: {"#": RegExp(r'[0-9a-z]')},
      type: MaskAutoCompletionType.lazy);

  @override
  String clearMask() {
    return '';
  }
}

class CardCVVFormatter extends Formatter {
  static final maskFormatter = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9a-z]')},
      type: MaskAutoCompletionType.lazy);

  @override
  String clearMask() {
    return '';
  }
}

class UserNameCardFormatter extends TextInputFormatter {
  UserNameCardFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.toUpperCase();

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
