import 'package:jackpot/domain/entities/bet_resume_entity.dart';

class BetResumeEntityMapper {
  static BetResumeEntity fromJson(Map<String, dynamic> data) {
    return BetResumeEntity(
        betId: data['id'].toString(),
        jackpotId: data['jackpotId'].toString(),
        expiresAt: DateTime.parse(data['endDate'].toString()));
  }
}
