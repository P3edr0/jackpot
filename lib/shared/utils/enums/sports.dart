enum SportsOptions {
  soccer,
  volleyball,
  basketball,
  futsal,
  tennis;

  bool get isSoccer => this == soccer;
  bool get isVolleyball => this == volleyball;
  bool get isBasketball => this == basketball;
  bool get isFutsal => this == futsal;
  bool get isTennis => this == tennis;

  String translateName() {
    switch (this) {
      case soccer:
        return 'Futebol';
      case volleyball:
        return 'Vôlei';
      case basketball:
        return 'Basquete';
      case futsal:
        return 'Futsal';

      default:
        return 'Tênis';
    }
  }
}
