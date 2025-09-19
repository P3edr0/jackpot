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
import 'package:jackpot/shared/utils/enums/bet_filters.dart';
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
  List<SportJackpotEntity> allBetJackpots = [];
  List<BetMadeEntity> _userBets = [];
  List<TemporaryBetEntity> _recoveredTemporaryBets = [];
  BetFilters _betStatusFilter = BetFilters.active;
  JackFiltersType _jackFiltersType = JackFiltersType.all;

  //////////////////////// GETS //////////////////////////////

  JackFiltersType get jackFiltersType => _jackFiltersType;
  BetFilters get betStatusFilter => _betStatusFilter;

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

  Future<void> getUserBetMade(
      String userDocument,
      List<SportJackpotEntity> allJackpots,
      List<AwardEntity> newAllAwards) async {
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
        _userBets.sort(
          (a, b) =>
              int.parse(b.couponNumber).compareTo(int.parse(a.couponNumber)),
        );
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
      final tempHandledBets = _recoveredTemporaryBets.map((bet) {
        return BetMadeEntity(
            betId: '',
            answers: [],
            couponNumber: 'xxx',
            createdAt: bet.createdAt,
            expireAt: DateTime(2026),
            jackpotId: bet.jackpotId,
            temporaryBet: bet,
            status: bet.status);
      }).toList();

      _userBets.addAll(tempHandledBets);
      log("Bets temporárias recuperadas com sucesso");
    });
    final Set<String> jackIds = userBets.map((bet) => bet.jackpotId!).toSet();
    final tempJackpotsIds =
        _recoveredTemporaryBets.map((tempBet) => tempBet.jackpotId).toSet();
    jackIds.addAll(tempJackpotsIds);
    final currentJackpots = allJackpots.map((item) => item.id).toList();
    final jackpotsToGet =
        jackIds.where((id) => (!currentJackpots.contains(id))).toList();

    if (allJackpots.isEmpty || jackpotsToGet.isNotEmpty) {
      final jacksCalls =
          jackIds.map((newJackId) => getJackpotUsecase(newJackId)).toList();

      final responses = await Future.wait(jacksCalls);
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
    } else {
      final newJackpots =
          allJackpots.where((newJack) => jackIds.contains(newJack.id)).toList();
      _exception = null;
      betJackpots = [...newJackpots];
    }
    if (_allAwards.isEmpty) {
      if (newAllAwards.isNotEmpty) {
        _allAwards = [...newAllAwards];
      } else {
        await _getAllAwards();
      }
    }

    if (_allAwards.isNotEmpty) {
      for (var jack in betJackpots) {
        final awards = jack.awardsId!
            .map((id) => _allAwards.firstWhere((award) => award.id == id))
            .toList();
        jack.awards = awards;
      }
    }
    allBetJackpots = [...betJackpots];
    setBetStatusFilter();
    setLoading(value: false);
  }

  Future<void> getJackpotBetMade(String userDocument, String jackpotId) async {
    setLoading(value: true);

    final response = await getBetMadeUsecase(userDocument);

    response.fold(
      (error) {
        _exception = error.message;
        notifyListeners();
      },
      (bets) {
        _exception = null;
        _userBets =
            bets.where((element) => element.jackpotId == jackpotId).toList();
        _userBets.sort(
          (a, b) =>
              int.parse(b.couponNumber).compareTo(int.parse(a.couponNumber)),
        );
      },
    );

    final tempBetResponse = await getTempBetsUsecase(userDocument);
    tempBetResponse.fold((l) {
      log("Falha ao recuperar as Bets temporarias.");
    }, (newTemporaryBets) {
      _recoveredTemporaryBets = newTemporaryBets
          .where((element) => element.jackpotId == jackpotId)
          .toList();
      final tempHandledBets = _recoveredTemporaryBets.map((bet) {
        return BetMadeEntity(
            betId: '',
            answers: [],
            couponNumber: 'xxx',
            createdAt: null,
            expireAt: DateTime(2026),
            jackpotId: bet.jackpotId,
            temporaryBet: bet,
            status: bet.status);
      }).toList();

      _userBets.addAll(tempHandledBets);
      log("Bets temporárias recuperadas com sucesso");
    });

    if (_userBets.isEmpty) {
      setLoading(value: false);
      return;
    }
    final jackResponse = await getJackpotUsecase(jackpotId);

    if (_allAwards.isEmpty) {
      await _getAllAwards();
    }

    jackResponse.fold((error) {
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

    if (_allAwards.isNotEmpty) {
      for (var jack in betJackpots) {
        final awards = jack.awardsId!
            .map((id) => _allAwards.firstWhere((award) => award.id == id))
            .toList();
        jack.awards = awards;
      }
    }
    allBetJackpots = [...betJackpots];
    setBetStatusFilter();
    setLoading(value: false);
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

  void setBetStatusFilter([BetFilters newBetStatus = BetFilters.active]) {
    _betStatusFilter = newBetStatus;

    switch (_betStatusFilter) {
      case BetFilters.awarded:
        betJackpots = [];
        break;
      case BetFilters.closed:
        final today = DateTime.now();

        final betIds = userBets
            .where((bet) => today.isAfter(bet.expireAt!))
            .toList()
            .map((filteredBet) => filteredBet.jackpotId)
            .toList();
        betJackpots = allBetJackpots
            .where((jackpot) => betIds.contains(jackpot.id))
            .toList();

      default:
        final today = DateTime.now();
        final betIds = userBets
            .where((bet) => today.isBefore(bet.expireAt!))
            .toList()
            .map((filteredBet) => filteredBet.jackpotId)
            .toList();

        betJackpots = allBetJackpots
            .where((jackpot) => betIds.contains(jackpot.id))
            .toList();
    }

    notifyListeners();
  }
}
