import 'package:flutter/material.dart';
import 'package:jackpot/data/temp_requests.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/utils/enums/home_tab.dart';
import 'package:jackpot/utils/enums/sports.dart';
import 'package:jackpot/utils/enums/sports_filters_type.dart';
import 'package:jackpot/utils/enums/tab_navigation_options.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;

  List<JackpotEntity> _extraJacks = [];
  List<JackpotEntity> _sportJacks = [];
  List<ChampionshipEntity> _championships = [];
  List<TeamEntity> _teams = [];
  final List<String> _states = ['GO', 'SP', 'RJ', 'MT', 'MG', 'PR', 'RS', 'RN'];

  final List<bool> _favoriteChampionships = [];
  List<bool> _selectedStates = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  HomeTab _selectedTab = HomeTab.sports;
  SportsFiltersType _sportsFiltersType = SportsFiltersType.teams;
  final SportsOptions _selectedSport = SportsOptions.soccer;
  JackTabNavigationOptions _selectedTabNavigationOption =
      JackTabNavigationOptions.home;
  //////////////////////// GETS //////////////////////////////
  List<String> get states => _states;

  List<bool> get favoriteChampionships => _favoriteChampionships;
  HomeTab get selectedTab => _selectedTab;
  SportsOptions get selectedSport => _selectedSport;
  List<JackpotEntity> get extraJacks => _extraJacks;
  List<JackpotEntity> get sportJacks => _sportJacks;
  List<TeamEntity> get teams => _teams;
  List<ChampionshipEntity> get championships => _championships;
  List<bool> get selectedStates => _selectedStates;
  JackTabNavigationOptions get selectedTabNavigationOption =>
      _selectedTabNavigationOption;
  SportsFiltersType get sportsFiltersType => _sportsFiltersType;

  //////////////////////// FUNCTIONS //////////////////////////////
  Future<void> startHomePage() async {
    setLoading();
    await Future.wait([
      fetchAllJacks(false),
      fetchAllTeams(false),
      fetchAllChampionships(false),
    ]);
    setLoading();
  }

  setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  setFavoriteSportsJacks(int index) {
    final newStatus = !sportJacks[index].isFavorite;
    List<JackpotEntity> tempList = [...sportJacks];

    tempList[index].isFavorite = newStatus;
    _sportJacks.clear();
    _sportJacks = [...tempList];
    notifyListeners();
  }

  setFavoriteExtraJacks(int index) {
    final newStatus = !extraJacks[index].isFavorite;
    List<JackpotEntity> tempList = [...extraJacks];

    tempList[index].isFavorite = newStatus;
    _extraJacks.clear();
    _extraJacks = [...tempList];
    notifyListeners();
  }

  fetchAllFavoriteChampionships(int count) {
    favoriteChampionships.clear();
    for (var i = 0; i < count; i++) {
      _favoriteChampionships.add(false);
    }
  }

  Future<void> fetchAllJacks([needLoading = true]) async {
    if (needLoading) setLoading();
    final tempJacks = await TempRequests.fetchAllJacks();
    _extraJacks = tempJacks;
    if (needLoading) setLoading();
  }

  Future<void> fetchAllTeams([needLoading = true]) async {
    if (needLoading) setLoading();
    final tempTeams = await TempRequests.fetchAllTeams();
    _teams = tempTeams;
    _sportJacks.clear();
    _sportJacks = [..._teams];
    if (needLoading) setLoading();
  }

  Future<void> fetchAllChampionships([needLoading = true]) async {
    if (needLoading) setLoading();
    final tempChampionships = await TempRequests.fetchAllChampionships();
    _championships = tempChampionships as List<ChampionshipEntity>;
    fetchAllFavoriteChampionships(_championships.length);
    if (needLoading) setLoading();
  }

  void setSelectedTab(HomeTab newTab) {
    _selectedTab = newTab;
    notifyListeners();
  }

  void setSelectedJackNavbarTab(JackTabNavigationOptions newNavbarTab) {
    _selectedTabNavigationOption = newNavbarTab;
    notifyListeners();
  }

  void setSportsFiltersType(SportsFiltersType filterType) {
    _sportsFiltersType = filterType;
    switch (_sportsFiltersType) {
      case SportsFiltersType.teams:
        _sportJacks.clear();
        _sportJacks = [..._teams];

        break;
      case SportsFiltersType.championship:
        _sportJacks.clear();
        _sportJacks = [..._championships];

        break;

      default:
        _sportJacks.clear();
        _sportJacks = [..._teams, ..._championships];
    }

    notifyListeners();
  }

  void setSelectedState(int index) {
    selectedStates[index] = !selectedStates[index];
    notifyListeners();
  }

  void clearSelectedState() {
    final newList = _selectedStates.map((item) => false);
    _selectedStates = newList.toList();
    notifyListeners();
  }
}
