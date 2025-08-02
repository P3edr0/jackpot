import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/create_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/delete_temp_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/update_temp_bet_usecase.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class JackpotController extends ChangeNotifier {
  JackpotController({
    required this.jackpotTeamController,
    required this.jackpotChampionshipController,
    required this.createBetUsecase,
    required this.updateTempBetUsecase,
    required this.deleteTempBetUsecase,
  });
  final JackpotTeamController jackpotTeamController;
  final JackpotChampionshipController jackpotChampionshipController;
  final CreateBetUsecase createBetUsecase;
  final UpdateTempBetUsecase updateTempBetUsecase;
  final DeleteTempBetUsecase deleteTempBetUsecase;

  //////////////////////// VARS //////////////////////////////

  String _selectedJackpotId = '';
  String _selectedJackpotImage = '';
  String _selectedJackpotLabel = '';
  List<JackpotEntity>? _selectedJackpot;
  List<TemporaryBetEntity> _temporaryBets = [];
  final List<TemporaryBetEntity> _recoveredTemporaryBets = [];
  //////////////////////// GETS //////////////////////////////

  String get selectedJackpotId => _selectedJackpotId;
  String get selectedJackpotImage => _selectedJackpotImage;
  String get selectedJackpotLabel => _selectedJackpotLabel;
  List<TemporaryBetEntity> get temporaryBets => _temporaryBets;
  List<TemporaryBetEntity> get recoveredTemporaryBets =>
      _recoveredTemporaryBets;

  List<JackpotEntity>? get selectedJackpot => _selectedJackpot;
  List<SportJackpotEntity>? get selectedSportsJackpot =>
      _getSelectedSportsJackpot();

  //////////////////////// FUNCTIONS //////////////////////////////

  List<SportJackpotEntity>? _getSelectedSportsJackpot() {
    if (selectedJackpot == null || selectedJackpot!.isEmpty) return null;

    final List<SportJackpotEntity> handledJacks = [];
    for (var jack in selectedJackpot!) {
      if (jack is SportJackpotEntity) {
        handledJacks.add(jack);
      }
    }
    return handledJacks;
  }

  Future<void> getChampionshipJackpot() async {
    final jackpot = await jackpotTeamController.getJackpot(_selectedJackpotId);
    if (jackpot == null) return;
    _selectedJackpot = [jackpot];
  }

  Future<void> setTemporaryBetContent(
      BetStatus newStatus, String userDocument) async {
    bool needSave = false;
    for (var bet in temporaryBets) {
      if (bet.status.name != newStatus.name) {
        needSave = true;
      }
      bet.status = newStatus;
    }
    if (!needSave) return;
    await saveBets(userDocument);
  }

  Future<void> removeTempBet(
      {required String paymentId, required String userDocument}) async {
    final response = await deleteTempBetUsecase(
        paymentId: paymentId, userDocument: userDocument);

    response.fold((l) {
      log("Falha ao deletar a Bet temporariamente.");
    }, (success) => log("Bet deletada com sucesso"));
  }

  Future<void> startTemporaryBets(PixEntity? pix, String userDocument) async {
    final createDate = DateTime.now();

    for (var bet in temporaryBets) {
      bet.createdAt = createDate;
      bet.pixCopyPaste = pix?.copyPaste;
      bet.pixQrCode = pix?.qrCode;
      bet.paymentId = pix?.id;
      bet.userDocument = userDocument;
    }

    await saveBets(userDocument);
  }

  Future<void> saveBets(String? userDocument) async {
    for (var bet in temporaryBets) {
      if (bet.userDocument == null ||
          bet.userDocument!.isEmpty && userDocument != null) {
        bet.userDocument = userDocument;
      }
    }

    final response = await updateTempBetUsecase(temporaryBets);

    response.fold((l) {
      log("Falha ao salvar as Bets temporariamente.");
    }, (success) => log("Bets salvas temporariamente com sucesso"));
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

  //////////////////////// GETS //////////////////////////////
  setTemporaryBets(List<TemporaryBetEntity> newTempBets) {
    _temporaryBets = newTempBets;
  }
}
