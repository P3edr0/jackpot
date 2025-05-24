import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_team_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/get_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_championship_jackpot_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_team_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class GetJackpotRepositoryImpl implements IGetJackpotRepository {
  GetJackpotRepositoryImpl({required this.datasource});
  IGetJackpotDatasource datasource;

  @override
  Future<Either<IJackExceptions, JackpotEntity>> call(String jackpotId) async {
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
