import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/usecases/bet/get_bet_made_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';

class MyJackpotsController extends ChangeNotifier {
  MyJackpotsController({
    required this.getJackpotUsecase,
    required this.listByTeamJackpotUsecase,
    required this.getBetMadeUsecase,
  });
  final GetJackpotUsecase getJackpotUsecase;
  final ListByTeamJackpotUsecase listByTeamJackpotUsecase;
  final GetBetMadeUsecase getBetMadeUsecase;

  //////////////////////// VARS //////////////////////////////
  String? _exception;

  bool isLoading = false;
  List<JackpotEntity> betJackpots = [];
  List<BetMadeEntity> _userBets = [];

  JackFiltersType _jackFiltersType = JackFiltersType.all;

  //////////////////////// GETS //////////////////////////////

  JackFiltersType get jackFiltersType => _jackFiltersType;

  String? get exception => _exception;
  bool get hasError => exception != null;
  List<BetMadeEntity> get userBets => _userBets;

  List<BetMadeEntity> getUserSelectedJackpotBets(JackpotEntity jackpot) {
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
  Future<JackpotEntity?> getJackpot(String selectedJackpotId) async {
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
        _userBets = bets;
        notifyListeners();
      },
    );
    if (_userBets.isEmpty) {
      setLoading(value: false);

      return;
    }

    final jackIds = userBets.map((bet) => bet.jackpotId).toList();

    final jacksCalls =
        jackIds.map((newJackId) => getJackpotUsecase(newJackId!)).toList();

    final responses = await Future.wait(jacksCalls);

    for (var response in responses) {
      response.fold((error) {
        _exception = error.message;
        notifyListeners();
      }, (jack) {
        bool added = false;

        for (var item in betJackpots) {
          if (item.id == jack.id) {
            added = true;
          }
        }
        if (!added) betJackpots.add(jack);
      });
    }
    setLoading(value: false);
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
