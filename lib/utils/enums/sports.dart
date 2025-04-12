enum SportsOptions {
  soccer,
  volleyball,
  basketball,
  futsal,
  tennis;

  bool get isSoccer => this == soccer;

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
