import 'package:flutter/widgets.dart';
import 'package:jackpot/domain/entities/question_structure_entity.dart';
import 'package:jackpot/shared/utils/enums/question_structure_type.dart';

class DoubleSubjectiveQuestionEntity extends QuestionStructureEntity {
  DoubleSubjectiveQuestionEntity({
    super.questionStructureType = QuestionStructureType.doubleSubjective,
    required this.firstController,
    required this.secondController,
  });
  final TextEditingController firstController;
  final TextEditingController secondController;

  @override
  bool isComplete() {
    final isFirstComplete = firstController.text.isNotEmpty;
    final isSecondComplete = secondController.text.isNotEmpty;
    final bool isComplete = (isFirstComplete && isSecondComplete);
    return isComplete;
  }
}
