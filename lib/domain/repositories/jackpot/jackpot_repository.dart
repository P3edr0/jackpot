import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetJackpotRepository {
  Future<Either<IJackExceptions, JackpotEntity>> call(String jackpotId);
}

abstract class IFetchAllTeamJackpotRepository {
  Future<Either<IJackExceptions, List<TeamEntity>>> call();
}

abstract class IListByTeamJackpotRepository {
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String teamId);
}

abstract class IListByChampionshipJackpotRepository {
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String championshipId);
}

abstract class IGroupByChampionshipJackpotRepository {
  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call();
}

abstract class ICreateBetRepository {
  Future<Either<IJackExceptions, bool>> call(BetEntity bet);
}
