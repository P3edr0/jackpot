import 'dart:convert';

import 'package:jackpot/domain/entities/question_item_entity.dart';
import 'package:jackpot/shared/utils/enums/question_quantity.dart';
import 'package:jackpot/shared/utils/enums/question_type.dart';

class QuestionItemEntityMapper {
  static QuestionItemEntity fromJson(Map<String, dynamic> data) {
    final content = jsonDecode(data['objOptions']);
    final optionsList = List<Map<String, dynamic>>.from(content);
    final options =
        optionsList.map((option) => option['value'].toString()).toList();
    return QuestionItemEntity(
      id: data['id'].toString(),
      potLevel: data['potLevel'],
      question: data['qString'],
      questionType: QuestionType.translate(data['qType']),
      questionQuantity: QuestionQuantity.translate(data['quantity']),
      subjSingleValue: data['subjSingleValue'],
      subjDoubleValue: data['subjDoubleValue'],
      objOptions: options,
    );
  }
}
