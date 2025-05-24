class ResumeTeamEntity {
  ResumeTeamEntity({
    required this.logo,
    required this.banner,
    required this.name,
    required this.id,
    this.jackpotId,
  });

  String name;
  String logo;
  String banner;
  String id;
  String? jackpotId;

  factory ResumeTeamEntity.empty(String id) {
    return ResumeTeamEntity(
      id: id,
      name: '',
      logo: '',
      banner: '',
      jackpotId: '',
    );
  }
  bool get haveJackpot => jackpotId != null;
}
