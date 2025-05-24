import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_team_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/preview_jackpot_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class ListByTeamJackpotDatasourceImpl implements IListByTeamJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String teamId) async {
    final dio = Dio();
    try {
      final response =
          await dio.get('${JackEnvironment.apiUrl}jackpot/listbyteam/$teamId',
              options: Options(
                headers: {
                  'accept': '*/*',
                },
              ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final teamsJackpot = lists
          .map((team) => PreviewJackpotEntityMapper.fromJson(team))
          .toList();

      return Right(teamsJackpot);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
