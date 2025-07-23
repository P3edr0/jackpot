import 'package:jackpot/shared/utils/enums/question_structure_type.dart';

abstract class QuestionStructureEntity {
  QuestionStructureEntity({
    required this.questionStructureType,
    required this.id,
  });
  QuestionStructureType questionStructureType;
  String id;
  bool isComplete();
}
