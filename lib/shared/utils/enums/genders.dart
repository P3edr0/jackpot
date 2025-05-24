enum Genders {
  male,
  female,
  notInformed;

  bool get isMale => this == male;
  bool get isFemale => this == female;
  bool get isNotInformed => this == notInformed;

  String getValue() {
    switch (this) {
      case female:
        return '3';
      case male:
        return '2';
      default:
        return '1';
    }
  }
}
