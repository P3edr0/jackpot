enum JackTabNavigationOptions {
  home,
  jacks,
  game,
  winners,
  wallet;

  bool get isHome => this == home;
  bool get isJacks => this == jacks;
  bool get isGame => this == game;
  bool get isWinners => this == winners;
  bool get isWallet => this == wallet;
}
