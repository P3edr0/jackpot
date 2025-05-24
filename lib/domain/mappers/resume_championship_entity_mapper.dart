import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';

class ResumeChampionshipEntityMapper {
  static ResumeChampionshipEntity fromJson(Map<String, dynamic> data) {
    final teams = List<Map<String, dynamic>>.from(data['teams']);
    final handledTeams =
        teams.map((team) => TeamEntity.empty(team['id'].toString())).toList();
    return ResumeChampionshipEntity(
        id: data['id'].toString(),
        name: data['name'],
        status: data['status'],
        banner: data['bannerURL'],
        endDate: DateTime.parse(data['endDate']),
        startDate: DateTime.parse(data['startDate']),
        teams: handledTeams);
  }
}
