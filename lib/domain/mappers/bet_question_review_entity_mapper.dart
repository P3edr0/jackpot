import 'package:jackpot/domain/entities/bet_question_review_entity.dart';

class BetQuestionReviewEntityMapper {
  static BetQuestionReviewEntity fromJson(Map<String, dynamic> data) {
    final objectiveAnswers =
        List<Map<String, dynamic>>.from(data['objectiveAnswers']);
    final subjectiveAnswers =
        List<Map<String, dynamic>>.from(data['subjectiveAnswers']);
    if (objectiveAnswers.isEmpty && subjectiveAnswers.isEmpty) {
      return BetQuestionReviewEntity(
        id: data['questionItemId'].toString(),
        answer: '',
        answerTwo: '',
      );
    }
    List<Map<String, dynamic>> contentList = objectiveAnswers;

    if (contentList.isEmpty) {
      contentList = subjectiveAnswers;
    }
    if (contentList.length == 1) {
      return BetQuestionReviewEntity(
        id: data['questionItemId'].toString(),
        answer: contentList.first['answer'],
        answerTwo: '',
      );
    } else {
      return BetQuestionReviewEntity(
        id: data['questionItemId'].toString(),
        answer: contentList.first['answer'],
        answerTwo: contentList[1]['answer'],
      );
    }
  }
}
