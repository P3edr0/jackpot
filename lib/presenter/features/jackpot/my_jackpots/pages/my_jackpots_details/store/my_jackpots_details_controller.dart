import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
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
  SportJackpotEntity? _betSelectedJackpot;
  List<BetMadeEntity> filteredUserBets = [];
  List<BetMadeEntity> _allUserBets = [];
  List<BetMadeEntity> _tempHandledBets = [];
  List<TemporaryBetEntity> _tempBets = [];

  BetFilters _betStatusFilter = BetFilters.active;

  //////////////////////// GETS //////////////////////////////

  BetFilters get betStatusFilter => _betStatusFilter;
  List<PreviewJackpotEntity> get teamPreviewJackpots => _teamPreviewJackpots;

  String? get exception => _exception;
  String get getPageTitle => _getPageTitle();
  // List<BetMadeEntity> get allUserBets => _allUserBets;
  List<BetMadeEntity> get tempHandledBets => _tempHandledBets;
  SportJackpotEntity? get betSelectedJackpot => _betSelectedJackpot;
  List<TemporaryBetEntity> get tempBets => _tempBets;

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

  setSelectedBetJackpot(SportJackpotEntity newJackpot) {
    _betSelectedJackpot = newJackpot;
    notifyListeners();
  }

  setSelectedTempBets(List<TemporaryBetEntity> newTempBets) {
    _tempBets = newTempBets;
    _tempHandledBets = _tempBets.map((bet) {
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

    notifyListeners();
  }

  String getBetAwards() {
    String awards = '';
    for (var award in _betSelectedJackpot!.awards!) {
      if (awards.trim().isEmpty) {
        awards = award.name;
        continue;
      }
      awards = '$awards | ${award.name}';
    }
    if (awards.trim().isEmpty) {
      return 'Vazio';
    }
    return awards;
  }

  setSelectedBets(List<BetMadeEntity> newBets) {
    _allUserBets = newBets;
    filteredUserBets = [...newBets];
    notifyListeners();
  }

  //////////////////////// FUNCTIONS //////////////////////////////

  void groupLists() {
    _allUserBets = [..._tempHandledBets, ..._allUserBets];
    setBetStatusFilter();
  }

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

  void setBetStatusFilter([BetFilters newBetStatus = BetFilters.active]) {
    _betStatusFilter = newBetStatus;

    switch (_betStatusFilter) {
      case BetFilters.awarded:
        filteredUserBets = [];
        break;
      case BetFilters.closed:
        final today = DateTime.now();
        filteredUserBets =
            _allUserBets.where((bet) => today.isAfter(bet.expireAt!)).toList();
        break;

      default:
        final today = DateTime.now();
        filteredUserBets =
            _allUserBets.where((bet) => today.isBefore(bet.expireAt!)).toList();
    }

    notifyListeners();
  }
}
