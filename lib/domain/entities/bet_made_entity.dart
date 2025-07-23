import 'package:jackpot/domain/entities/bet_question_review_entity.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class BetMadeEntity {
  BetMadeEntity({
    required this.couponNumber,
    required this.betId,
    required this.createdAt,
    required this.answers,
    this.expireAt,
    this.jackpotId,
    this.status,
  });

  String couponNumber;
  String betId;
  String createdAt;
  List<BetQuestionReviewEntity> answers;
  String? jackpotId;
  DateTime? expireAt;
  BetStatus? status;
}
