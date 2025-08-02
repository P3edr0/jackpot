import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/mappers/bet_question_review_entity_mapper.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class BetMadeEntityMapper {
  static BetMadeEntity fromJson(Map<String, dynamic> data) {
    final contentAnswers =
        List<Map<String, dynamic>>.from(data['jackpotAnswers']);
    final answers = contentAnswers
        .map((answer) => BetQuestionReviewEntityMapper.fromJson(answer))
        .toList();
    final String? createdAt = data['createdAt'];
    DateTime? handledCreateAt;
    if (createdAt != null && createdAt != '') {
      final dates = createdAt.split('/');
      final year = int.parse(dates.last);
      final day = int.parse(dates[1]);
      final month = int.parse(dates.first);

      handledCreateAt = DateTime(year, month, day);
    }
    return BetMadeEntity(
      betId: data['betId'].toString(),
      couponNumber: data['id'].toString(),
      createdAt: handledCreateAt,
      status: BetStatus.answered,
      answers: answers,
    );
  }
}
