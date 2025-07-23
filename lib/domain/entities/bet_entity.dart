import 'package:jackpot/domain/entities/question_group_entity.dart';

class BetEntity {
  BetEntity(
      {required this.userEmail,
      required this.userDocument,
      required this.paymentId,
      required this.userName,
      required this.quantity,
      required this.amount,
      required this.betId,
      required this.winningQuestion,
      required this.answers,
      required this.createdAt});
  String userEmail;
  String userDocument;
  String userName;
  String paymentId;
  int quantity;
  double amount;
  DateTime createdAt;

  String betId;
  int winningQuestion;
  List<QuestionGroupEntity> answers;
}
