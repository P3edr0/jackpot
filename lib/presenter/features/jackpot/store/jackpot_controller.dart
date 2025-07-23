import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/usecases/jackpot/create_bet_usecase.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';

class JackpotController extends ChangeNotifier {
  JackpotController({
    required this.jackpotTeamController,
    required this.jackpotChampionshipController,
    required this.createBetUsecase,
  });
  final JackpotTeamController jackpotTeamController;
  final JackpotChampionshipController jackpotChampionshipController;
  final CreateBetUsecase createBetUsecase;

  //////////////////////// VARS //////////////////////////////

  String _selectedJackpotId = '';
  String _selectedJackpotImage = '';
  String _selectedJackpotLabel = '';
  List<JackpotEntity>? _selectedJackpot;
  //////////////////////// GETS //////////////////////////////

  String get selectedJackpotId => _selectedJackpotId;
  String get selectedJackpotImage => _selectedJackpotImage;
  String get selectedJackpotLabel => _selectedJackpotLabel;
  List<JackpotEntity>? get selectedJackpot => _selectedJackpot;

  //////////////////////// FUNCTIONS //////////////////////////////

  Future<void> getJackpot() async {
    final jackpot = await jackpotTeamController.getJackpot(_selectedJackpotId);
    if (jackpot == null) return;
    _selectedJackpot = [jackpot];
  }

  Future<void> getChampionshipJackpot() async {
    final jackpot = await jackpotTeamController.getJackpot(_selectedJackpotId);
    if (jackpot == null) return;
    _selectedJackpot = [jackpot];
  }

  setSelectedJackpotDetails(
      {required String newId, required String image, required String label}) {
    _selectedJackpotId = newId;
    _selectedJackpotLabel = label;
    _selectedJackpotImage = image;
  }

  setSelectedJackpot(List<JackpotEntity>? jackpot) {
    _selectedJackpot = jackpot;
    notifyListeners();
  }

  Future<bool> createBet(
      {required String userName,
      required String betId,
      required String paymentId,
      required String userEmail,
      required String userDocument,
      required List<QuestionGroupEntity> answers,
      required double amount}) async {
    final quantity = answers.length;
    final bet = BetEntity(
        userEmail: userEmail,
        userDocument: userDocument,
        userName: userName,
        quantity: quantity,
        amount: amount,
        betId: betId,
        paymentId: paymentId,
        createdAt: DateTime.now().toUtc(),
        winningQuestion: 0,
        answers: answers);
    final response = await createBetUsecase(bet);
    return response.fold(
      (l) {
        log(l.message);
        return false;
      },
      (r) {
        return r;
      },
    );
  }
}
