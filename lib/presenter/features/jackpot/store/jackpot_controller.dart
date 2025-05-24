import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';

class JackpotController extends ChangeNotifier {
  JackpotController(
      {required this.jackpotTeamController,
      required this.jackpotChampionshipController});
  final JackpotTeamController jackpotTeamController;
  final JackpotChampionshipController jackpotChampionshipController;

  //////////////////////// VARS //////////////////////////////

  String _selectedJackpotId = '';
  String _selectedJackpotImage = '';
  String _selectedJackpotLabel = '';
  JackpotEntity? _selectedJackpot;

  //////////////////////// GETS //////////////////////////////

  String get selectedJackpotId => _selectedJackpotId;
  String get selectedJackpotImage => _selectedJackpotImage;
  String get selectedJackpotLabel => _selectedJackpotLabel;
  JackpotEntity? get selectedJackpot => _selectedJackpot;

  //////////////////////// FUNCTIONS //////////////////////////////
  Future<void> getJackpot() async {
    _selectedJackpot =
        await jackpotTeamController.getJackpot(_selectedJackpotId);

    if (_selectedJackpot == null) {
    } else {}
  }

  Future<void> getChampionshipJackpot() async {
    _selectedJackpot =
        await jackpotChampionshipController.getJackpot(_selectedJackpotId);

    if (_selectedJackpot == null) {
    } else {}
  }

  setSelectedJackpotDetails(
      {required String newId, required String image, required String label}) {
    _selectedJackpotId = newId;
    _selectedJackpotLabel = label;
    _selectedJackpotImage = image;
  }

  setSelectedJackpot(JackpotEntity? jackpot) {
    _selectedJackpot = jackpot;
    notifyListeners();
  }
}
