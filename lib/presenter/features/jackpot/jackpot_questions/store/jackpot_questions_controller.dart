import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_question_review_entity.dart';
import 'package:jackpot/domain/entities/double_subjective_question.dart';
import 'package:jackpot/domain/entities/objective_question_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/entities/shopping_cart_jackpot_entity.dart';
import 'package:jackpot/domain/entities/single_subjective_question.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';

class JackpotQuestionsController extends ChangeNotifier {
  //////////////////////// VARS //////////////////////////////
  bool _isQuestionsPreview = false;
  bool _isLoading = false;
  List<JackpotAggregateEntity> _betQueue = [];
  QuestionGroupEntity _questionsStructure = QuestionGroupEntity(questions: []);
  List<QuestionGroupEntity> _questionsStructurePages = [];
  SportJackpotEntity? _selectedJackpot;
  int? _couponsQuantity;
  int _currentQuestionPage = 1;
  int _completedQuestions = 0;
  bool _acceptTerms = false;
  bool _isLastPage = false;
  bool _validQuestionFields = false;
  QuestionGroupEntity _previewQuestionStructure =
      QuestionGroupEntity(questions: []);
  //////////////////////// GETS //////////////////////////////
  SportJackpotEntity? get selectedJackpot => _selectedJackpot;
  int? get couponsQuantity => _couponsQuantity;
  int get currentQuestionPage => _currentQuestionPage;
  int get remainQuestions => couponsQuantity! - _completedQuestions;
  int get completedQuestions => _completedQuestions;
  QuestionGroupEntity get questionsStructure => _questionsStructure;
  List<QuestionGroupEntity> get questionsStructurePages =>
      _questionsStructurePages;
  List<JackpotAggregateEntity> get betQueue => _betQueue;
  bool get hasMultipleBets => _betQueue.length > 1;
  bool get isLoading => _isLoading;
  QuestionGroupEntity get previewQuestionStructure => _previewQuestionStructure;

  bool get acceptTerms => _acceptTerms;
  bool get isLastPage => _isLastPage;
  bool get validQuestionFields => _validQuestionFields;
  bool get canBackQuestionPage => _currentQuestionPage > 1;
  bool get canSkipQuestionPage =>
      _currentQuestionPage < couponsQuantity! && _validQuestionFields;
  bool get isQuestionsPreview => _isQuestionsPreview;

  //////////////////////// FUNCTIONS //////////////////////////////

  clearFields() {
    _selectedJackpot = null;
    _acceptTerms = false;
  }

  setLoading([bool? newLoading]) {
    if (newLoading != null) {
      _isLoading = newLoading;

      notifyListeners();
      return;
    }
    _isLoading = !_isLoading;
    notifyListeners();
  }

  setIsQuestionsPreview(
      {required bool newIsQuestionPreview,
      required List<JackpotAggregateEntity> newJackpots,
      List<BetQuestionReviewEntity> betQuestions = const []}) {
    _isQuestionsPreview = newIsQuestionPreview;
    if (_isQuestionsPreview) {
      startJackpotStructure(
        newJackpots: newJackpots,
        isPreview: _isQuestionsPreview,
        betAnswers: betQuestions,
      );

      _questionsStructure = _previewQuestionStructure;
    } else {
      startJackpotStructure(
          newJackpots: newJackpots,
          betAnswers: betQuestions,
          isPreview: _isQuestionsPreview);

      _questionsStructure = _questionsStructurePages.first;
    }
    notifyListeners();
  }

  void backQuestionPage() {
    if (!canBackQuestionPage) return;

    _currentQuestionPage -= 1;
    _questionsStructure = _questionsStructurePages[_currentQuestionPage - 1];
    _isLastPage = false;
    checkCanSkipPage();

    notifyListeners();
  }

  void checkIsLastPage() {
    if (_currentQuestionPage == _couponsQuantity) {
      _isLastPage = true;
    } else {
      _isLastPage = false;
    }
    notifyListeners();
  }

  void setRemainQuestions() {
    if (_currentQuestionPage - 1 > _completedQuestions) {
      _completedQuestions = _currentQuestionPage - 1;
      notifyListeners();
    }
  }

  void skipQuestionPage() {
    if (!canSkipQuestionPage) return;

    _currentQuestionPage += 1;
    _questionsStructure = _questionsStructurePages[_currentQuestionPage - 1];
    checkIsLastPage();
    checkCanSkipPage();
    setRemainQuestions();
    notifyListeners();
  }

  void setSelectedOption(int questionIndex, int optionIndex) {
    final newList = [..._questionsStructure.questions];
    final objectiveQuestion = newList[questionIndex] as ObjectiveQuestionEntity;
    if (objectiveQuestion.selectedList[optionIndex]) return;
    for (int index = 0;
        index < objectiveQuestion.selectedList.length;
        index++) {
      if (index == optionIndex) {
        objectiveQuestion.selectedList[index] = true;
      } else {
        objectiveQuestion.selectedList[index] = false;
      }
    }

    newList[questionIndex] = objectiveQuestion;
    _questionsStructure.questions = [...newList];
    checkCanSkipPage();
    notifyListeners();
  }

  void checkCanSkipPage() {
    for (var question in _questionsStructure.questions) {
      if (question.isComplete() == false) {
        _validQuestionFields = false;
        notifyListeners();
        return;
      }
    }
    _validQuestionFields = true;
    notifyListeners();
  }

  void startJackpotStructure(
      {required List<JackpotAggregateEntity> newJackpots,
      required List<BetQuestionReviewEntity> betAnswers,
      bool isPreview = false}) {
    if (!isPreview) {
      _betQueue = [...newJackpots];
    }
    _currentQuestionPage = 1;
    _selectedJackpot = newJackpots.first.jackpot;
    _couponsQuantity = newJackpots.first.couponsQuantity;
    checkIsLastPage();
    _completedQuestions = 0;
    final questions = _selectedJackpot!.questions.items;
    _questionsStructurePages = [];
    for (var i = 0; i <= couponsQuantity!; i++) {
      final QuestionGroupEntity tempQuestionsStructure =
          QuestionGroupEntity(questions: []);

      for (var question in questions) {
        if (question.questionType.isObjective) {
          final int listLength = question.objOptions.length;
          List<bool> initialList = [];
          if (betAnswers.isNotEmpty) {
            final answer =
                betAnswers.firstWhere((element) => element.id == question.id);
            for (var option in question.objOptions) {
              if (answer.answer == option) {
                initialList.add(true);
              } else {
                initialList.add(false);
              }
            }
          } else {
            initialList = List.generate(listLength, (index) => false);
          }

          final objectiveQuestionStructure = ObjectiveQuestionEntity(
            id: question.id,
            options: question.objOptions,
            selectedList: initialList,
          );

          tempQuestionsStructure.questions.add(objectiveQuestionStructure);
        } else {
          if (question.questionQuantity.isSingle) {
            String answer = '';
            if (betAnswers.isNotEmpty) {
              final handledAnswer =
                  betAnswers.firstWhere((element) => element.id == question.id);
              answer = handledAnswer.answer;
            }

            final singleSubjectiveQuestionStructure =
                SingleSubjectiveQuestionEntity(
                    id: question.id,
                    controller: TextEditingController(text: answer));
            tempQuestionsStructure.questions
                .add(singleSubjectiveQuestionStructure);
          } else {
            String answer = '';
            String answerTwo = '';
            if (betAnswers.isNotEmpty) {
              final handledAnswer =
                  betAnswers.firstWhere((element) => element.id == question.id);
              answer = handledAnswer.answer;
              answerTwo = handledAnswer.answerTwo;
            }
            final doubleSubjectiveQuestionStructure =
                DoubleSubjectiveQuestionEntity(
              id: question.id,
              firstController: TextEditingController(text: answer),
              secondController: TextEditingController(text: answerTwo),
            );
            tempQuestionsStructure.questions
                .add(doubleSubjectiveQuestionStructure);
          }
        }
      }
      if (i == couponsQuantity) {
        _previewQuestionStructure = tempQuestionsStructure;
      } else {
        _questionsStructurePages.add(tempQuestionsStructure);
      }
    }
    _questionsStructure = _questionsStructurePages.first;
    notifyListeners();
  }
  //////////////////////// SETS //////////////////////////////

  void setAcceptTerms() {
    _acceptTerms = !_acceptTerms;
    notifyListeners();
  }
}
