import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:jackpot/domain/usecases/jackpot/list_by_championship_jackpot_usecase.dart';
import 'package:jackpot/shared/utils/enums/jack_filters_type.dart';

class JackpotChampionshipController extends ChangeNotifier {
  JackpotChampionshipController(
      {required this.getJackpotUsecase,
      required this.listByChampionshipJackpotUsecase});
  final GetJackpotUsecase getJackpotUsecase;
  final ListByChampionshipJackpotUsecase listByChampionshipJackpotUsecase;
  //////////////////////// VARS //////////////////////////////

  bool isLoading = true;
  List<PreviewJackpotEntity> _championshipPreviewJackpots = [];
  String _selectedChampionshipId = '';
  String? _selectedFilterTeamId;
  String _selectedChampionshipBanner = '';
  String _selectedChampionshipName = '';
  bool isTeamInChampionshipLoading = false;
  final searchController = TextEditingController();
  JackFiltersType _jackFiltersType = JackFiltersType.all;
  final Set<TeamEntity> _filterTeams = {};
  List<JackpotEntity> _championshipCompleteJackpots = [];
  List<JackpotEntity> _allChampionshipCompleteJackpots = [];

  //////////////////////// GETS //////////////////////////////
  String get selectedChampionshipId => _selectedChampionshipId;
  String get selectedChampionshipBanner => _selectedChampionshipBanner;
  String get selectedChampionshipName => _selectedChampionshipName;
  String? get selectedFilterTeamId => _selectedFilterTeamId;
  Set<TeamEntity> get filterTeams => _filterTeams;

  JackFiltersType get jackFiltersType => _jackFiltersType;
  List<PreviewJackpotEntity> get championshipPreviewJackpots =>
      _championshipPreviewJackpots;
  List<JackpotEntity> get championshipCompleteJackpots =>
      _championshipCompleteJackpots;
  List<JackpotEntity> get allChampionshipCompleteJackpots =>
      _allChampionshipCompleteJackpots;
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

  void setSelectedChampionshipData(
      {required String newId,
      required String newBanner,
      required String newChampionshipName}) {
    _selectedChampionshipId = newId;
    _selectedChampionshipBanner = newBanner;
    _selectedChampionshipName = newChampionshipName;
    notifyListeners();
  }

  setTeamInChampionshipLoading({bool? value}) {
    if (value == null) {
      isTeamInChampionshipLoading = !isTeamInChampionshipLoading;
      notifyListeners();
      return;
    }
    isTeamInChampionshipLoading = value;
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

  Future<void> getChampionshipPreviewJackpots() async {
    setLoading(value: true);
    final response =
        await listByChampionshipJackpotUsecase(_selectedChampionshipId);

    return response.fold((exception) {
      setLoading(value: false);

      return null;
    }, (newChampionshipJackpots) async {
      _championshipPreviewJackpots = newChampionshipJackpots;

      final calls = _championshipPreviewJackpots
          .map(
            (e) => getJackpot(e.jackpotId),
          )
          .toList();
      final responses = await Future.wait(calls);
      final newJacks = responses.where((item) => item != null).toList();
      _championshipCompleteJackpots = List<JackpotEntity>.from(newJacks);
      filterTeams.clear();
      for (var element in _championshipCompleteJackpots) {
        final bool contain =
            filterTeams.any((team) => team.id == element.jackpotOwnerTeam.id);
        if (!contain) {
          filterTeams.add(element.jackpotOwnerTeam);
        }
      }
      _allChampionshipCompleteJackpots = [..._championshipCompleteJackpots];
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

  void searchFilter() {
    final content = searchController.text.toLowerCase();
    if (content.trim().isEmpty) {
      _championshipCompleteJackpots = [...allChampionshipCompleteJackpots];
      notifyListeners();

      return;
    }
    final handledTeams = filterTeams
        .where((team) => team.name.toLowerCase().contains(content))
        .toList();
    final List<JackpotEntity> tempList = [];
    for (var team in handledTeams) {
      final filteredJack = allChampionshipCompleteJackpots
          .firstWhere((champ) => champ.jackpotOwnerTeam.id == team.id);
      tempList.add(filteredJack);
    }
    _championshipCompleteJackpots = tempList;

    notifyListeners();
  }

  void setTeamFilter(String teamId) {
    if (selectedFilterTeamId == teamId) {
      _selectedFilterTeamId = null;
      _championshipCompleteJackpots = [..._allChampionshipCompleteJackpots];
      notifyListeners();

      return;
    }
    _selectedFilterTeamId = teamId;
    _championshipCompleteJackpots = _allChampionshipCompleteJackpots
        .where((element) => element.homeTeam.id == teamId)
        .toList();

    notifyListeners();
  }
}
