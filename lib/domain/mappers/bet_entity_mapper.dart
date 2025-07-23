import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/mappers/answers_group_mapper.dart';

class BetEntityMapper {
  static Map<String, dynamic> toJson(BetEntity bet) {
    final List<Map<String, dynamic>> answers = [];

    for (var answersGroup in bet.answers) {
      final tempList = AnswersGroupMapper.toList(answersGroup);

      answers.addAll(tempList);
    }

    final Map<String, dynamic> data = <String, dynamic>{
      "id": 0,
      "userEmail": bet.userEmail,
      "userName": bet.userName,
      "userDocument": bet.userDocument,
      "quantity": bet.quantity,
      "amount": bet.amount,
      "betId": int.parse(bet.betId),
      "paymentId": bet.paymentId,
      "createdAt": bet.createdAt.toIso8601String(),
      "winningQuestion": 0,
      "jackpotAnswers": answers
    };

    return data;
  }
}
