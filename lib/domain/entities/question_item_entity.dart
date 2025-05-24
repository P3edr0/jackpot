import 'package:jackpot/shared/utils/enums/question_quantity.dart';
import 'package:jackpot/shared/utils/enums/question_type.dart';

class QuestionItemEntity {
  QuestionItemEntity({
    required this.id,
    required this.potLevel,
    required this.question,
    required this.questionType,
    required this.questionQuantity,
    required this.objOptions,
    required this.subjSingleValue,
    required this.subjDoubleValue,
  });
  String id;
  int potLevel;
  String question;
  QuestionType questionType;
  QuestionQuantity questionQuantity;
  List<String> objOptions;
  String subjSingleValue;
  String subjDoubleValue;
}
