import 'package:jackpot/domain/entities/question_structure_entity.dart';

class QuestionGroupEntity {
  QuestionGroupEntity({
    required this.questions,
  });
  List<QuestionStructureEntity> questions;
}
