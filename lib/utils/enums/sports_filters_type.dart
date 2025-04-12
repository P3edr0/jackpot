enum SportsFiltersType {
  teams,
  championship,
  all;

  bool get isTeams => this == teams;
  bool get isChampionship => this == championship;
  bool get isAll => this == all;
}
