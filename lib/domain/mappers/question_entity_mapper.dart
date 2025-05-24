import 'package:jackpot/domain/entities/question_entity.dart';
import 'package:jackpot/domain/mappers/question_item_entity_mapper.dart';

class QuestionEntityMapper {
  static QuestionEntity fromJson(Map<String, dynamic> data) {
    final questionsItems = List<Map<String, dynamic>>.from(data['items']);
    final items = questionsItems
        .map((item) => QuestionItemEntityMapper.fromJson(item))
        .toList();
    items.sort((a, b) => a.potLevel.compareTo(b.potLevel));
    return QuestionEntity(
      id: data['id'].toString(),
      title: data['title'],
      category: data['category'],
      createAt: DateTime.tryParse(data['createDate']),
      items: items,
    );
  }
}
