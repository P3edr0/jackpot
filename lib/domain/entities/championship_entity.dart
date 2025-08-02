import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/entities/resume_team_entity.dart';
import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class ChampionshipEntity extends ResumeJackpotEntity {
  ChampionshipEntity(
      {required super.jackpotId,
      required super.title,
      required super.banner,
      required super.potValue,
      required super.isFavorite,
      required this.teams,
      required this.name,
      required this.id,
      super.jackpotType = SportJackpotType.championship});
  String id;
  String name;
  List<ResumeTeamEntity> teams;

  factory ChampionshipEntity.empty(String id) {
    return ChampionshipEntity(
      banner: '',
      id: id,
      isFavorite: false,
      jackpotId: '',
      name: '',
      potValue: '',
      teams: [],
      title: '',
    );
  }
}
