enum QuestionType {
  subjective,
  objective;

  bool get isObjective => this == objective;

  static QuestionType translate(String value) {
    switch (value) {
      case 'Objetiva':
        return objective;
      default:
        return subjective;
    }
  }
}
