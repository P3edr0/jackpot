import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/mappers/question_entity_mapper.dart';

class SportsJackpotEntityMapper {
  static SportJackpotEntity fromJson(Map<String, dynamic> data) {
    final championshipId = data['idChampionship'].toString();
    final homeTeamId = data['customEvent']['homeTeamId'].toString();
    final visitorTeamId = data['customEvent']['visitorTeamId'].toString();
    final jackpotOwnerTeamId = data['idTeams'].first.toString();
    final date = data['dateJackpotEnding'] as String;
    final time = data['hourJackpotEnding'] as String;
    final jackDate = parseJackpotDate('$date $time');
    final dateMatch = data['customEvent']['startDate'] as String;
    final timeMatch = data['customEvent']['startTime'] as String;
    final matchDate = parseJackpotDate('$dateMatch $timeMatch');
    final awardIds = List<int>.from(data['idAwards']);
    final handledAwardIds = awardIds.map((id) => id.toString()).toList();

    return SportJackpotEntity(
        id: data['id'].toString(),
        betId: data['betId'].toString(),
        championship: ResumeChampionshipEntity.empty(championshipId),
        banner: data['bannerUrl'],
        potValue: data['potValue'],
        endAt: jackDate,
        matchTime: matchDate,
        budgetValue: data['budgetValue'],
        awardsId: handledAwardIds,
        description: data['description'],
        questionId: data['idQuestion'].toString(),
        homeTeam: TeamEntity.empty(homeTeamId),
        jackpotOwnerTeam: TeamEntity.empty(jackpotOwnerTeamId),
        visitorTeam: TeamEntity.empty(visitorTeamId),
        questions: QuestionEntityMapper.fromJson(data['question']));
  }
}

DateTime parseJackpotDate(String date) {
  return DateTime.parse(date);
}
