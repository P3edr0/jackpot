enum QuestionStructureType {
  singleSubjective,
  doubleSubjective,
  objective;

  bool get isSingleSubjective => this == singleSubjective;
  bool get isDoubleSubjective => this == doubleSubjective;
  bool get isObjective => this == objective;
}
