import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/usecases/bet/get_bet_made_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/bet_filters.dart';

class MyJackpotsDetailsController extends ChangeNotifier {
  MyJackpotsDetailsController({
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
  final List<PreviewJackpotEntity> _teamPreviewJackpots = [];
  JackpotEntity? _betSelectedJackpot;
  List<BetMadeEntity> _allUserBets = [];
  List<BetMadeEntity> filteredUserBets = [];

  BetFilters _betStatusFilter = BetFilters.active;

  //////////////////////// GETS //////////////////////////////

  BetFilters get betStatusFilter => _betStatusFilter;
  List<PreviewJackpotEntity> get teamPreviewJackpots => _teamPreviewJackpots;

  String? get exception => _exception;
  String get getPageTitle => _getPageTitle();
  List<BetMadeEntity> get allUserBets => _allUserBets;
  JackpotEntity? get betSelectedJackpot => _betSelectedJackpot;

  String _getPageTitle() {
    final label =
        '${_betSelectedJackpot!.homeTeam.name} x ${_betSelectedJackpot!.visitorTeam.name}';
    return label;
  }
  //////////////////////// SETS //////////////////////////////

  setLoading({bool? value}) {
    if (value == null) {
      isLoading = !isLoading;
      notifyListeners();
      return;
    }
    isLoading = value;
    notifyListeners();
  }

  setSelectedBetJackpot(JackpotEntity newJackpot) {
    _betSelectedJackpot = newJackpot;
    notifyListeners();
  }

  setSelectedBets(List<BetMadeEntity> newBets) {
    _allUserBets = newBets;
    filteredUserBets = [...newBets];
    setBetStatusFilter();
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

  void setBetStatusFilter([BetFilters newBetStatus = BetFilters.active]) {
    _betStatusFilter = newBetStatus;

    switch (_betStatusFilter) {
      case BetFilters.awarded:
        filteredUserBets = [];
        break;
      case BetFilters.closed:
        final today = DateTime.now();
        filteredUserBets =
            allUserBets.where((bet) => today.isAfter(bet.expireAt!)).toList();
        break;

      default:
        final today = DateTime.now();
        filteredUserBets =
            allUserBets.where((bet) => today.isBefore(bet.expireAt!)).toList();
    }

    notifyListeners();
  }
}
