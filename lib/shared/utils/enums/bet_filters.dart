enum BetFilters {
  active,
  closed,
  awarded;

  bool get isActive => this == active;
  bool get isClosed => this == closed;
  bool get isAwarded => this == awarded;
}
