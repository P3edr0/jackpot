import 'package:jackpot/domain/entities/bet_question_review_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class BetMadeEntity {
  BetMadeEntity(
      {required this.couponNumber,
      required this.betId,
      required this.createdAt,
      required this.answers,
      this.expireAt,
      this.jackpotId,
      this.status,
      this.temporaryBet});

  String couponNumber;
  String betId;
  DateTime? createdAt;
  List<BetQuestionReviewEntity> answers;
  String? jackpotId;
  DateTime? expireAt;
  BetStatus? status;
  TemporaryBetEntity? temporaryBet;
}
