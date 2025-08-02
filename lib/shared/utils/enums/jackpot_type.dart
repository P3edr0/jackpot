enum SportJackpotType {
  team,
  championship;

  bool get isTeam => this == team;
  bool get isChampionship => this == championship;
}

enum JackpotType {
  sport,
  extra;

  bool get isExtra => this == extra;
  bool get isSport => this == sport;
}
