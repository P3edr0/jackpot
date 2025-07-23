import 'package:jackpot/domain/entities/question_structure_entity.dart';
import 'package:jackpot/shared/utils/enums/question_structure_type.dart';

class ObjectiveQuestionEntity extends QuestionStructureEntity {
  ObjectiveQuestionEntity({
    super.questionStructureType = QuestionStructureType.objective,
    required super.id,
    required this.options,
    required this.selectedList,
  });
  List<String> options;
  List<bool> selectedList;

  @override
  bool isComplete() {
    final bool isComplete = selectedList.any((element) => element == true);
    return isComplete;
  }
}
