enum JackFiltersType {
  pots,
  awards,
  all;

  bool get isPots => this == pots;
  bool get isAwards => this == awards;
  bool get isAll => this == all;
}
