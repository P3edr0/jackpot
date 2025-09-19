import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetJackpotRepository {
  Future<Either<IJackExceptions, SportJackpotEntity>> call(String jackpotId);
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

abstract class IFetchAllResumeJackpotRepository {
  Future<Either<IJackExceptions, List<ResumeJackpotEntity>>> call();
}

abstract class IGroupByChampionshipJackpotRepository {
  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call();
}

abstract class ICreateBetRepository {
  Future<Either<IJackExceptions, bool>> call(BetEntity bet);
}

abstract class IUpdateTempBetRepository {
  Future<Either<IJackExceptions, bool>> call(List<TemporaryBetEntity> tempBets);
}

abstract class IGetTempBetRepository {
  Future<Either<IJackExceptions, List<TemporaryBetEntity>>> call(
      String userDocument);
}

abstract class IDeleteTempBetRepository {
  Future<Either<IJackExceptions, bool>> call(
      String userDocument, String paymentId, String jackpotId);
}
///////////////////////// EXTRA ///////////////////////////////

abstract class IFetchExtraJackpotRepository {
  Future<Either<IJackExceptions, List<ExtraJackpotEntity>>> call();
}
