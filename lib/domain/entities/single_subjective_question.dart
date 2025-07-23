import 'package:flutter/widgets.dart';
import 'package:jackpot/domain/entities/question_structure_entity.dart';
import 'package:jackpot/shared/utils/enums/question_structure_type.dart';

class SingleSubjectiveQuestionEntity extends QuestionStructureEntity {
  SingleSubjectiveQuestionEntity({
    required super.id,
    super.questionStructureType = QuestionStructureType.singleSubjective,
    required this.controller,
  });
  TextEditingController controller;

  @override
  bool isComplete() {
    final isComplete = controller.text.isNotEmpty;
    return isComplete;
  }
}
