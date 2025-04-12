import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';

class ChampionshipEntity extends JackpotEntity {
  ChampionshipEntity({
    required super.id,
    required super.title,
    required super.banner,
    required super.potValue,
    required super.isFavorite,
    required this.teams,
    required this.name,
  });
  String name;
  List<TeamEntity> teams;
}
