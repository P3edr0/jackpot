import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/question_entity.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class SportJackpotEntity extends JackpotEntity {
  SportJackpotEntity(
      {required super.id,
      required super.betId,
      super.awards,
      required super.awardsId,
      required super.banner,
      required super.budgetValue,
      required super.description,
      required super.endAt,
      required super.potValue,
      required this.championship,
      required this.matchTime,
      required this.questionId,
      required this.homeTeam,
      required this.visitorTeam,
      required this.jackpotOwnerTeam,
      required this.questions,
      super.jackpotType = JackpotType.sport});
  DateTime matchTime;
  String questionId;
  TeamEntity homeTeam;
  TeamEntity visitorTeam;
  TeamEntity jackpotOwnerTeam;
  ResumeChampionshipEntity championship;
  QuestionEntity questions;
}
