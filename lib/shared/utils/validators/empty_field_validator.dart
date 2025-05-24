class EmptyFieldValidator {
  String? call(String value) {
    final bool isValid = value.trim().isNotEmpty;
    if (isValid) return null;

    return "Este campo não pode ser vazio";
  }
}
