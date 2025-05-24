import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_team_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';

class JackpotTeamController extends ChangeNotifier {
  JackpotTeamController({
    required this.getJackpotUsecase,
    required this.listByTeamJackpotUsecase,
  });
  final GetJackpotUsecase getJackpotUsecase;
  final ListByTeamJackpotUsecase listByTeamJackpotUsecase;

  //////////////////////// VARS //////////////////////////////
  String _selectedTeamId = '';
  String _selectedTeamBanner = '';
  String _selectedTeamName = '';
  bool isLoading = true;
  List<PreviewJackpotEntity> _teamPreviewJackpots = [];
  List<JackpotEntity> teamCompleteJackpots = [];

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

  Future<void> getTeamJackpots() async {
    setLoading(value: true);
    final response = await listByTeamJackpotUsecase(_selectedTeamId);

    return response.fold((exception) {
      setLoading(value: false);

      return null;
    }, (newTeamJackpots) async {
      _teamPreviewJackpots = newTeamJackpots;

      final calls = _teamPreviewJackpots
          .map(
            (e) => getJackpot(e.jackpotId),
          )
          .toList();
      final responses = await Future.wait(calls);
      final newJacks = responses.where((item) => item != null).toList();
      teamCompleteJackpots = List<JackpotEntity>.from(newJacks);
      setLoading(value: false);

      return;
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
