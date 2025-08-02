import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_bet_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_temp_bet_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/get_temp_bets_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/extra/fetch_extra_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/get_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/group_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_team_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class GetJackpotRepositoryImpl implements IGetJackpotRepository {
  GetJackpotRepositoryImpl({required this.datasource});
  IGetJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, SportJackpotEntity>> call(
      String jackpotId) async {
    final response = await datasource(jackpotId);
    return response;
  }
}

class FetchAllTeamJackpotRepositoryImpl
    implements IFetchAllTeamJackpotRepository {
  FetchAllTeamJackpotRepositoryImpl({required this.datasource});
  IFetchAllTeamJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<TeamEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}

class ListByTeamJackpotRepositoryImpl implements IListByTeamJackpotRepository {
  ListByTeamJackpotRepositoryImpl({required this.datasource});
  IListByTeamJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String teamId) async {
    final response = await datasource(teamId);
    return response;
  }
}

class ListByChampionshipJackpotRepositoryImpl
    implements IListByChampionshipJackpotRepository {
  ListByChampionshipJackpotRepositoryImpl({required this.datasource});
  IListByChampionshipJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String championshipId) async {
    final response = await datasource(championshipId);
    return response;
  }
}

class GroupByChampionshipJackpotRepositoryImpl
    implements IGroupByChampionshipJackpotRepository {
  GroupByChampionshipJackpotRepositoryImpl({required this.datasource});
  IGroupByChampionshipJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}

class CreateBetRepositoryImpl implements ICreateBetRepository {
  CreateBetRepositoryImpl({required this.datasource});
  ICreateBetDatasource datasource;

  @override
  Future<Either<IJackExceptions, bool>> call(BetEntity bet) async {
    final response = await datasource(bet);
    return response;
  }
}

class UpdateTempBetRepositoryImpl implements IUpdateTempBetRepository {
  UpdateTempBetRepositoryImpl({required this.datasource});
  IUpdateTempBetDatasource datasource;

  @override
  Future<Either<IJackExceptions, bool>> call(
      List<TemporaryBetEntity> tempBets) async {
    final response = await datasource(tempBets);
    return response;
  }
}

class GetTempBetRepositoryImpl implements IGetTempBetRepository {
  GetTempBetRepositoryImpl({required this.datasource});
  IGetTempBetsDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<TemporaryBetEntity>>> call(
      String userDocument) async {
    final response = await datasource(userDocument);
    return response;
  }
}

/////////////////// EXTRA /////////////////////////

class FetchExtraJackpotRepositoryImpl implements IFetchExtraJackpotRepository {
  FetchExtraJackpotRepositoryImpl({required this.datasource});
  IFetchExtraJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<ExtraJackpotEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}
