import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/question_group_entity.dart';
import 'package:jackpot/domain/usecases/jackpot/bet/create_bet_usecase.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_championship/store/jackpot_championship_controller.dart';
import 'package:jackpot/presenter/features/jackpot/jackpot_team/store/jackpot_team_controller.dart';

class ExtraJackpotController extends ChangeNotifier {
  ExtraJackpotController({
    required this.jackpotTeamController,
    required this.jackpotChampionshipController,
    required this.createBetUsecase,
  });
  final JackpotTeamController jackpotTeamController;
  final JackpotChampionshipController jackpotChampionshipController;
  final CreateBetUsecase createBetUsecase;

  //////////////////////// VARS //////////////////////////////

  String _selectedJackpotId = '';
  String _selectedJackpotImage = '';
  String _selectedJackpotLabel = '';
  List<ExtraJackpotEntity>? _selectedJackpot;
  //////////////////////// GETS //////////////////////////////

  String get selectedJackpotId => _selectedJackpotId;
  String get selectedJackpotImage => _selectedJackpotImage;
  String get selectedJackpotLabel => _selectedJackpotLabel;
  List<ExtraJackpotEntity>? get selectedJackpot => _selectedJackpot;

  //////////////////////// FUNCTIONS //////////////////////////////

  Future<void> getJackpot() async {
    final jackpot = await jackpotTeamController.getJackpot(_selectedJackpotId);
    if (jackpot == null) return;
    _selectedJackpot = [];
  }

  Future<void> getChampionshipJackpot() async {
    final jackpot = await jackpotTeamController.getJackpot(_selectedJackpotId);
    if (jackpot == null) return;
    _selectedJackpot = [];
  }

  setSelectedJackpotDetails(
      {required String newId, required String image, required String label}) {
    _selectedJackpotId = newId;
    _selectedJackpotLabel = label;
    _selectedJackpotImage = image;
  }

  setSelectedJackpot(List<ExtraJackpotEntity>? jackpot) {
    _selectedJackpot = jackpot;
    notifyListeners();
  }

  Future<bool> createBet(
      {required NewUserEntity user,
      required String betId,
      required List<QuestionGroupEntity> answers,
      required double amount}) async {
    // final quantity = answers.length;
    // final bet = BetEntity(
    //     uzerId: user.uzerId!.toString(),
    //     userImage: user.image!,
    //     userName: user.name!,
    //     quantity: quantity,
    //     amount: amount,
    //     betId: betId,
    //     winningQuestion: 0,
    //     answers: answers);
    // final response = await createBetUsecase(bet);
    // return response.fold(
    //   (l) {
    //     log(l.message);
    //     return false;
    //   },
    //   (r) {
    //     return r;
    //   },
    return false;
  }
}
