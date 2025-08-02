import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/usecases/award/fetch_all_awards_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';

class JackpotTeamController extends ChangeNotifier {
  JackpotTeamController({
    required this.getJackpotUsecase,
    required this.fetchAllAwardsUsecase,
    required this.listByTeamJackpotUsecase,
  });
  final FetchAllAwardsUsecase fetchAllAwardsUsecase;
  final GetJackpotUsecase getJackpotUsecase;
  final ListByTeamJackpotUsecase listByTeamJackpotUsecase;

  //////////////////////// VARS //////////////////////////////
  String _selectedTeamId = '';
  String _selectedTeamBanner = '';
  String _selectedTeamName = '';
  bool isLoading = true;
  List<PreviewJackpotEntity> _teamPreviewJackpots = [];
  List<SportJackpotEntity> teamCompleteJackpots = [];
  List<AwardEntity> _allAwards = [];

  JackFiltersType _jackFiltersType = JackFiltersType.all;

  //////////////////////// GETS //////////////////////////////

  JackFiltersType get jackFiltersType => _jackFiltersType;
  List<PreviewJackpotEntity> get teamPreviewJackpots => _teamPreviewJackpots;
  String get selectedTeamId => _selectedTeamId;
  String get selectedTeamBanner => _selectedTeamBanner;
  String get selectedTeamName => _selectedTeamName;

  //////////////////////// FUNCTIONS //////////////////////////////
  void setSelectedTeamData(
      {required String newId,
      required String newBanner,
      required String newTeamName}) {
    _selectedTeamId = newId;
    _selectedTeamBanner = newBanner;
    _selectedTeamName = newTeamName;
    notifyListeners();
  }

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

  Future<void> getTeamJackpots() async {
    setLoading(value: true);
    final response = await listByTeamJackpotUsecase(_selectedTeamId);

    return response.fold((exception) {
      setLoading(value: false);

      return null;
    }, (newTeamJackpots) async {
      await _getAllAwards();

      _teamPreviewJackpots = newTeamJackpots;
      final calls = _teamPreviewJackpots
          .map(
            (e) => getJackpot(e.jackpotId),
          )
          .toList();
      final responses = await Future.wait(calls);
      final newJacks = responses.where((item) => item != null).toList();

      teamCompleteJackpots = List<SportJackpotEntity>.from(newJacks);
      if (_allAwards.isNotEmpty) {
        for (var jack in teamCompleteJackpots) {
          final awards = jack.awardsId!
              .map((id) => _allAwards.firstWhere((award) => award.id == id))
              .toList();
          jack.awards = awards;
        }
      }
      setLoading(value: false);

      return;
    });
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
