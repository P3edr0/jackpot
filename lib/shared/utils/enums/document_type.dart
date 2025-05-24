enum DocumentType {
  cpf;

  bool get isCpf => this == cpf;

  int getValue() {
    switch (this) {
      case cpf:
        return 4;
    }
  }
}
