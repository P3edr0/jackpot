import 'package:jackpot/domain/entities/double_subjective_question.dart';
import 'package:jackpot/domain/entities/objective_question_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/entities/single_subjective_question.dart';

class AnswersGroupMapper {
  static List<Map<String, dynamic>> toList(QuestionGroupEntity group) {
    List<Map<String, dynamic>> data = [];
    for (var question in group.questions) {
      Map<String, dynamic> questionData = <String, dynamic>{};

      if (question.questionStructureType.isObjective) {
        final handledQuestion = question as ObjectiveQuestionEntity;
        final answerIndex = handledQuestion.selectedList.indexOf(true);
        final String answer = handledQuestion.options[answerIndex];
        questionData = {
          "questionItemId": int.parse(question.id),
          "questionItem": {
            "id": int.parse(question.id),
            "potLevel": 0,
            "qId": 0,
            "qString": "",
            "qType": "",
            "objOptions": "",
            "quantity": "",
            "subjSingleValue": "",
            "subjDoubleValue": ""
          },
          "objectiveAnswers": [
            {"objectiveOptionId": 0, "answer": answer},
          ],
          "subjectiveAnswers": [
       
      ]
    };
        data.add(questionData);
      }
      if (question.questionStructureType.isSingleSubjective) {
        final handledQuestion = question as SingleSubjectiveQuestionEntity;
        final String answer = handledQuestion.controller.text;
        questionData = {
          "questionItemId": int.parse(question.id),
          "questionItem": {
            "id": int.parse(question.id),
            "potLevel": 0,
            "qId": 0,
            "qString": "",
            "qType": "",
            "objOptions": "",
            "quantity": "",
            "subjSingleValue": "",
            "subjDoubleValue": ""
          },
          "objectiveAnswers": [],
          "subjectiveAnswers": [
            {"subjectiveOptionId": 0, "answer": answer},
          ]
        };
        data.add(questionData);
      }

      if (question.questionStructureType.isDoubleSubjective) {
        final handledQuestion = question as DoubleSubjectiveQuestionEntity;
        final String firstAnswer = handledQuestion.firstController.text;
        final String secondAnswer = handledQuestion.secondController.text;
        questionData = {
          "questionItemId": int.parse(question.id),
          "questionItem": {
            "id": int.parse(question.id),
            "potLevel": 0,
            "qId": 0,
            "qString": "",
            "qType": "",
            "objOptions": "",
            "quantity": "",
            "subjSingleValue": "",
            "subjDoubleValue": ""
          },
          "objectiveAnswers": [],
          "subjectiveAnswers": [
            {"subjectiveOptionId": 0, "answer": firstAnswer},
            {"subjectiveOptionId": 1, "answer": secondAnswer},
          ]
        };
        data.add(questionData);
      }
    }

    return data;
  }
}
