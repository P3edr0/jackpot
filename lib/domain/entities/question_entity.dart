import 'package:jackpot/domain/entities/question_item_entity.dart';

class QuestionEntity {
  QuestionEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.createAt,
    required this.items,
  });
  String id;
  String title;
  String category;
  DateTime? createAt;
  List<QuestionItemEntity> items;
}
