import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/championship/championship_repository.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';
import 'package:jackpot/domain/repositories/team/team_repository.dart';

class GetJackpotUsecase {
  GetJackpotUsecase({
    required this.repository,
    required this.teamRepository,
    required this.championshipRepository,
    required this.fetchAllTeamJackpotRepository,
  });
  IGetJackpotRepository repository;
  IGetTeamRepository teamRepository;
  IGetChampionshipRepository championshipRepository;
  IFetchAllTeamJackpotRepository fetchAllTeamJackpotRepository;
  Future<Either<IJackExceptions, JackpotEntity>> call(String jackpotId) async {
    if (jackpotId.trim().isEmpty) {
      return Left(
          DataException(message: 'O Id do jackpot não pode ser vazio.'));
    }

    final response = await repository(jackpotId);
    IJackExceptions? exception;
    return response.fold((error) {
      return Left(error);
    }, (jackpot) async {
      final homeTeamId = jackpot.homeTeam.id;
      final visitorTeamId = jackpot.visitorTeam.id;
      final championshipId = jackpot.championship.id;

      final responses = await Future.wait([
        fetchAllTeamJackpotRepository(),
        championshipRepository(championshipId),
      ]);
      List<TeamEntity> handledAllTeams = [];
      final allJackpotTeamsResponse = responses.first;
      allJackpotTeamsResponse.fold((error) {
        exception = error;
      }, (allTeams) {
        handledAllTeams = allTeams as List<TeamEntity>;
      });
      if (exception != null) {
        return Left(exception!);
      }

      TeamEntity? homeTeam;
      TeamEntity? visitorTeam;
      ResumeChampionshipEntity? championship;
      homeTeam = handledAllTeams.firstWhere((team) => team.id == homeTeamId);
      visitorTeam =
          handledAllTeams.firstWhere((team) => team.id == visitorTeamId);

      var championshipResponse = responses[1];
      championshipResponse.fold((championshipError) {
        exception = championshipError;
      }, (champ) {
        championship = champ as ResumeChampionshipEntity;
      });

      if (exception != null) {
        return Left(exception!);
      }
      jackpot.homeTeam = homeTeam;
      jackpot.visitorTeam = visitorTeam;
      if (homeTeam.id == jackpot.jackpotOwnerTeam.id) {
        jackpot.jackpotOwnerTeam = homeTeam;
      } else {
        jackpot.jackpotOwnerTeam = visitorTeam;
      }

      final championshipTeamIds =
          championship!.teams.map((team) => team.id).toList();
      final championshipTeams = handledAllTeams
          .where((team) => championshipTeamIds.contains(team.id))
          .toList();
      for (var team in handledAllTeams) {
        for (var champTeam in championshipTeams) {
          if (champTeam.id == team.id) {
            champTeam.jackpotId = team.jackpotId;
            champTeam.banner = team.banner;
          }
        }
      }

      championship!.teams = championshipTeams;
      jackpot.championship = championship!;

      return Right(jackpot);
    });
  }
}
