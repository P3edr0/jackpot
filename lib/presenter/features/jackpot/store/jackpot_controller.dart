import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/usecases/award/fetch_all_awards_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/create_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/delete_temp_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/update_temp_bet_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/fetch_all_jackpot_resume_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class JackpotController extends ChangeNotifier {
  JackpotController(
      {required this.jackpotTeamController,
      required this.jackpotChampionshipController,
      required this.createBetUsecase,
      required this.updateTempBetUsecase,
      required this.deleteTempBetUsecase,
      required this.fetchAllResumeJackpotsUsecase,
      required this.fetchAllAwardsUsecase,
      required this.getJackpotUsecase});
  final JackpotTeamController jackpotTeamController;
  final JackpotChampionshipController jackpotChampionshipController;
  final CreateBetUsecase createBetUsecase;
  final GetJackpotUsecase getJackpotUsecase;
  final UpdateTempBetUsecase updateTempBetUsecase;
  final FetchAllResumeJackpotUsecase fetchAllResumeJackpotsUsecase;
  final DeleteTempBetUsecase deleteTempBetUsecase;
  final FetchAllAwardsUsecase fetchAllAwardsUsecase;

  //////////////////////// VARS //////////////////////////////

  String _selectedJackpotId = '';
  String _selectedJackpotImage = '';
  String _selectedJackpotLabel = '';
  List<AwardEntity> _allAwards = [];

  List<JackpotEntity>? _selectedJackpot;
  List<TemporaryBetEntity> _temporaryBets = [];
  final List<TemporaryBetEntity> _recoveredTemporaryBets = [];
  List<SportJackpotEntity> _allCompleteJackpots = [];
  List<ResumeJackpotEntity> _allResumeJackpots = [];
  //////////////////////// GETS //////////////////////////////

  String get selectedJackpotId => _selectedJackpotId;
  String get selectedJackpotImage => _selectedJackpotImage;
  String get selectedJackpotLabel => _selectedJackpotLabel;
  List<TemporaryBetEntity> get temporaryBets => _temporaryBets;
  List<SportJackpotEntity> get allCompleteJackpots => _allCompleteJackpots;
  List<ResumeJackpotEntity> get allResumeJackpots => _allResumeJackpots;
  List<AwardEntity> get allAwards => _allAwards;
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

  Future<void> getAllAwards() async {
    final response = await fetchAllAwardsUsecase();
    response.fold((exception) {
      _allAwards = [];
    }, (newAwards) async {
      _allAwards = newAwards;
    });
  }

  Future<void> fetchAllJackpots() async {
    final response = await fetchAllResumeJackpotsUsecase();
    response.fold(
      (exception) {
        _allResumeJackpots = [];
      },
      (newResumeJackpots) async {
        _allResumeJackpots = newResumeJackpots;
        bool needUpdate = false;
        if (_allCompleteJackpots.isEmpty) {
          needUpdate = true;
        } else {
          if (_allCompleteJackpots.length != _allResumeJackpots.length) {
            needUpdate = true;
          }

          final completeIds =
              allCompleteJackpots.map((item) => item.id).toList();

          for (var element in _allResumeJackpots) {
            if (!completeIds.contains(element.jackpotId)) {
              needUpdate = true;
              break;
            }
          }
        }
        if (!needUpdate) return;

        final completeJackpotsCalls = _allResumeJackpots
            .map((item) => getJackpotUsecase(item.jackpotId))
            .toList();
        final responses = await Future.wait(completeJackpotsCalls);

        final List<SportJackpotEntity> tempCompleteJackpots = [];
        for (var completeJackpotResponse in responses) {
          completeJackpotResponse.fold((l) {}, (newJackpot) {
            tempCompleteJackpots.add(newJackpot);
          });
        }

        _allCompleteJackpots = [...tempCompleteJackpots];
        log(_allCompleteJackpots.toString(), name: 'Lista Completa');
      },
    );
  }

  Future<void> removeTempBet(
      {required String paymentId,
      required String userDocument,
      required String jackpotId}) async {
    final response = await deleteTempBetUsecase(
        paymentId: paymentId, userDocument: userDocument, jackpotId: jackpotId);

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

    if (temporaryBets.length > 1) {
      final paymentValue = temporaryBets
          .map((bet) => (bet.couponPrice * bet.couponQuantity))
          .toList()
          .reduce((value, element) => value + element);
      for (var bet in temporaryBets) {
        bet.paymentValue = paymentValue;
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
      required double couponPrice}) async {
    final bets = answers
        .map((answer) => BetEntity(
            userEmail: userEmail,
            userDocument: userDocument,
            userName: userName,
            quantity: 1,
            amount: couponPrice,
            betId: betId,
            paymentId: paymentId,
            createdAt: DateTime.now().toUtc(),
            winningQuestion: 0,
            answers: [answer]))
        .toList();
    final calls = bets.map((bet) => createBetUsecase(bet)).toList();

    final responses = await Future.wait(calls);
    bool success = true;
    for (var response in responses) {
      response.fold(
        (l) {
          log(l.message);
          success = false;
        },
        (r) {
          r;
        },
      );
    }
    return success;
  }

  //////////////////////// GETS //////////////////////////////
  setTemporaryBets(List<TemporaryBetEntity> newTempBets) {
    _temporaryBets = newTempBets;
  }
}
