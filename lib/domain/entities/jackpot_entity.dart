import 'package:jackpot/domain/entities/question_entity.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';

class JackpotEntity {
  JackpotEntity({
    required this.id,
    required this.championship,
    required this.banner,
    required this.potValue,
    required this.endAt,
    required this.matchTime,
    required this.budgetValue,
    required this.awardsId,
    required this.description,
    required this.questionId,
    required this.homeTeam,
    required this.visitorTeam,
    required this.jackpotOwnerTeam,
    required this.questions,
  });
  ResumeChampionshipEntity championship;
  String id;
  String banner;
  String potValue;
  DateTime endAt;
  DateTime matchTime;
  String budgetValue;
  String questionId;
  TeamEntity homeTeam;
  TeamEntity visitorTeam;
  TeamEntity jackpotOwnerTeam;
  String description;
  List<String> awardsId;
  QuestionEntity questions;
}
