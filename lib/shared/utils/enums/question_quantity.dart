enum QuestionQuantity {
  single,
  double;

  bool get isSingle => this == single;

  static QuestionQuantity translate(String value) {
    switch (value) {
      case 'Unico':
        return single;
      default:
        return double;
    }
  }
}
