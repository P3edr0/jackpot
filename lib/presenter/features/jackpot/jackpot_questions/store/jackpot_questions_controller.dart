import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/double_subjective_question.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/objective_question_entity.dart';
import 'package:jackpot/domain/entities/question_structure_entity.dart';
import 'package:jackpot/domain/entities/single_subjective_question.dart';

class JackpotQuestionsController extends ChangeNotifier {
  //////////////////////// VARS //////////////////////////////
  bool _isQuestionsPreview = false;

  List<QuestionStructureEntity> _questionsStructure = [];
  List<List<QuestionStructureEntity>> _questionsStructurePages = [];
  JackpotEntity? _selectedJackpot;
  int? _couponsQuantity;
  int _currentQuestionPage = 1;
  int _completedQuestions = 0;
  JackpotQuestionsController();
  bool _acceptTerms = false;
  bool _isLastPage = false;
  bool _validQuestionFields = false;
  List<QuestionStructureEntity> _previewQuestionStructure = [];
  //////////////////////// GETS //////////////////////////////
  JackpotEntity? get selectedJackpot => _selectedJackpot;
  int? get couponsQuantity => _couponsQuantity;
  int get currentQuestionPage => _currentQuestionPage;
  int get remainQuestions => couponsQuantity! - _completedQuestions;
  int get completedQuestions => _completedQuestions;
  List<QuestionStructureEntity> get questionsStructure => _questionsStructure;
  List<List<QuestionStructureEntity>> get questionsStructurePages =>
      _questionsStructurePages;
  List<QuestionStructureEntity> get previewQuestionStructure =>
      _previewQuestionStructure;
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

  setIsQuestionsPreview(bool value, JackpotEntity newJackpot,
      [int coupons = 1]) {
    _isQuestionsPreview = value;
    if (_isQuestionsPreview) {
      startJackpotStructure(newJackpot, coupons);

      _questionsStructure = _previewQuestionStructure;
    } else {
      startJackpotStructure(newJackpot, coupons);

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
    final newList = [..._questionsStructure];
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
    _questionsStructure = [...newList];
    checkCanSkipPage();
    notifyListeners();
  }

  void checkCanSkipPage() {
    for (var question in _questionsStructure) {
      if (question.isComplete() == false) {
        _validQuestionFields = false;
        notifyListeners();
        return;
      }
    }
    _validQuestionFields = true;
    notifyListeners();
  }

  void startJackpotStructure(JackpotEntity newJackpot, int newCouponsQuantity) {
    if (newJackpot.id == _selectedJackpot?.id &&
        _couponsQuantity == newCouponsQuantity) {
      return;
    }
    _currentQuestionPage = 1;
    _selectedJackpot = newJackpot;
    _couponsQuantity = newCouponsQuantity;
    checkIsLastPage();
    _completedQuestions = 0;
    final questions = _selectedJackpot!.questions.items;
    _questionsStructurePages = [];
    for (var i = 0; i <= couponsQuantity!; i++) {
      final List<QuestionStructureEntity> tempQuestionsStructure = [];

      for (var question in questions) {
        if (question.questionType.isObjective) {
          final int listLength = question.objOptions.length;
          final initialList = List.generate(listLength, (index) => false);
          final objectiveQuestionStructure = ObjectiveQuestionEntity(
            options: question.objOptions,
            selectedList: initialList,
          );

          tempQuestionsStructure.add(objectiveQuestionStructure);
        } else {
          if (question.questionQuantity.isSingle) {
            final singleSubjectiveQuestionStructure =
                SingleSubjectiveQuestionEntity(
                    controller: TextEditingController());
            tempQuestionsStructure.add(singleSubjectiveQuestionStructure);
          } else {
            final doubleSubjectiveQuestionStructure =
                DoubleSubjectiveQuestionEntity(
              firstController: TextEditingController(),
              secondController: TextEditingController(),
            );
            tempQuestionsStructure.add(doubleSubjectiveQuestionStructure);
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
