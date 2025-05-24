import 'package:jackpot/domain/entities/team_entity.dart';

class ResumeChampionshipEntity {
  ResumeChampionshipEntity({
    required this.status,
    required this.banner,
    required this.name,
    required this.id,
    required this.teams,
    required this.startDate,
    required this.endDate,
  });

  String name;
  bool status;
  String banner;
  String id;
  DateTime? startDate;
  DateTime? endDate;
  List<TeamEntity> teams;

  factory ResumeChampionshipEntity.empty(String id) {
    return ResumeChampionshipEntity(
      id: id,
      name: '',
      status: true,
      banner: '',
      endDate: null,
      startDate: null,
      teams: [],
    );
  }
}
