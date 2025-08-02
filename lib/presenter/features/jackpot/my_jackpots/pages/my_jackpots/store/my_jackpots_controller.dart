import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/usecases/award/fetch_all_awards_usecase.dart';
import 'package:jackpot/domain/usecases/bet/get_bet_made_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/get_temp_bets_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';

class MyJackpotsController extends ChangeNotifier {
  MyJackpotsController(
      {required this.getJackpotUsecase,
      required this.listByTeamJackpotUsecase,
      required this.getBetMadeUsecase,
      required this.getTempBetsUsecase,
      required this.fetchAllAwardsUsecase});
  final GetJackpotUsecase getJackpotUsecase;
  final ListByTeamJackpotUsecase listByTeamJackpotUsecase;
  final GetBetMadeUsecase getBetMadeUsecase;
  final FetchAllAwardsUsecase fetchAllAwardsUsecase;
  final GetTempBetsUsecase getTempBetsUsecase;

  //////////////////////// VARS //////////////////////////////
  String? _exception;
  List<AwardEntity> _allAwards = [];
  bool isLoading = false;
  List<SportJackpotEntity> betJackpots = [];
  List<BetMadeEntity> _userBets = [];
  List<TemporaryBetEntity> _recoveredTemporaryBets = [];

  JackFiltersType _jackFiltersType = JackFiltersType.all;

  //////////////////////// GETS //////////////////////////////

  JackFiltersType get jackFiltersType => _jackFiltersType;

  String? get exception => _exception;
  bool get hasError => exception != null;
  List<BetMadeEntity> get userBets => _userBets;
  List<TemporaryBetEntity> get recoveredTemporaryBets =>
      _recoveredTemporaryBets;

  List<BetMadeEntity> getUserSelectedJackpotBets(SportJackpotEntity jackpot) {
    final jackId = jackpot.id;
    final handledBets =
        _userBets.where((bet) => bet.jackpotId == jackId).toList();
    return handledBets;
  }

  //////////////////////// FUNCTIONS //////////////////////////////

  setLoading({bool? value}) {
    if (value == null) {
      isLoading = !isLoading;
      notifyListeners();
      return;
    }
    isLoading = value;
    notifyListeners();
  }

  //////////////////////// FUNCTIONS //////////////////////////////
  Future<SportJackpotEntity?> getJackpot(String selectedJackpotId) async {
    setLoading(value: true);
    final response = await getJackpotUsecase(selectedJackpotId);

    return response.fold((exception) {
      setLoading(value: false);

      return null;
    }, (newJackpot) {
      setLoading(value: false);

      return newJackpot;
    });
  }

  Future<void> getUserBetMade(String userDocument) async {
    setLoading(value: true);

    final response = await getBetMadeUsecase(userDocument);

    response.fold(
      (error) {
        _exception = error.message;
        notifyListeners();
      },
      (bets) {
        _exception = null;
        _userBets = bets;
        notifyListeners();
      },
    );
    if (_userBets.isEmpty) {
      setLoading(value: false);

      return;
    }
    final tempBetResponse = await getTempBetsUsecase(userDocument);
    tempBetResponse.fold((l) {
      log("Falha ao recuperar as Bets temporarias.");
    }, (newTemporaryBets) {
      _recoveredTemporaryBets = newTemporaryBets;

      log("Bets salvas temporariamente com sucesso");
      notifyListeners();
    });
    final Set<String> jackIds = userBets.map((bet) => bet.jackpotId!).toSet();
    final tempJackpotsIds =
        _recoveredTemporaryBets.map((tempBet) => tempBet.jackpotId).toSet();
    jackIds.addAll(tempJackpotsIds);
    final jacksCalls =
        jackIds.map((newJackId) => getJackpotUsecase(newJackId)).toList();

    final responses = await Future.wait(jacksCalls);
    await _getAllAwards();
    for (var response in responses) {
      response.fold((error) {
        _exception = error.message;
        notifyListeners();
      }, (jack) async {
        _exception = null;

        bool added = false;

        for (var item in betJackpots) {
          if (item.id == jack.id) {
            added = true;
          }
        }
        if (!added) betJackpots.add(jack);
      });
    }
    if (_allAwards.isNotEmpty) {
      for (var jack in betJackpots) {
        final awards = jack.awardsId!
            .map((id) => _allAwards.firstWhere((award) => award.id == id))
            .toList();
        jack.awards = awards;
      }
    }
    setLoading(value: false);
  }

  List<TemporaryBetEntity> getSelectedTempBets(String jackpotId) {
    final selectedTempBets = _recoveredTemporaryBets
        .where((item) => item.jackpotId == jackpotId)
        .toList();

    return selectedTempBets;
  }

  Future<void> _getAllAwards() async {
    final response = await fetchAllAwardsUsecase();
    response.fold((exception) {
      _allAwards = [];
    }, (newAwards) async {
      _allAwards = newAwards;
    });
  }

  void setJackFiltersType(JackFiltersType filterType) {
    _jackFiltersType = filterType;
    switch (_jackFiltersType) {
      case JackFiltersType.all:
        break;
      case JackFiltersType.awards:
        break;

      default:
    }

    notifyListeners();
  }
}
