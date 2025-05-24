class CredentialValidator {
  String? call(bool isEmail, String value) {
    if (isEmail) {
      final handledValue = value.trim();

      if (!handledValue.contains('@') ||
          !handledValue.contains('.') ||
          handledValue.endsWith('.')) {
        return 'Insira um email válido';
      }
      return null;
    } else {
      final handledValue = value.replaceAll(RegExp('[.-]+'), '');

      final isValid = isValidCPF(handledValue);

      if (!isValid) {
        return 'Insira um CPF válido';
      }
      return null;
    }
  }

  bool isValidCPF(String value) {
    final handledCpf = value.replaceAll(RegExp(r'\D'), '');

    if (handledCpf.length != 11) return false;

    // Check if all digits are the same
    if (RegExp(r'^(\d)\1*$').hasMatch(handledCpf)) return false;

    // Calculate the first verification digit
    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(handledCpf[i]) * (10 - i);
    }

    var digit1 = (sum * 10) % 11;
    if (digit1 == 10) {
      digit1 = 0;
    }

    if (digit1 != int.parse(handledCpf[9])) {
      return false;
    }

    // Calculate the second verification digit
    sum = 0;
    for (var i = 0; i < 10; i++) {
      sum += int.parse(handledCpf[i]) * (11 - i);
    }
    var digit2 = (sum * 10) % 11;
    if (digit2 == 10) {
      digit2 = 0;
    }

    // Check if the verification digits match the CPF digits
    if (digit2 != int.parse(handledCpf[10])) {
      return false;
    }

    return true;
  }
}
