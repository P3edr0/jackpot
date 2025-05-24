import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_team_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/team_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class FetchAllTeamJackpotDatasourceImpl
    implements IFetchAllTeamJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<TeamEntity>>> call() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('${JackEnvironment.apiUrl}jackpot/groupbyteam',
              options: Options(
                headers: {
                  'accept': '*/*',
                },
              ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final teams =
          lists.map((team) => TeamEntityMapper.fromJson(team)).toList();
      final teamsIds = teams.map((team) => team.id).toSet();

      List<TeamEntity> filteredTeams = [];

      for (var element in teamsIds) {
        final newTeam = teams.firstWhere((team) => team.id == element);
        filteredTeams.add(newTeam);
      }
      return Right(filteredTeams);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
