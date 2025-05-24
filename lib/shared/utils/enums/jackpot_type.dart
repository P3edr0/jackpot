enum JackpotType {
  team,
  championship;

  bool get isTeam => this == team;
  bool get isChampionship => this == championship;
}
