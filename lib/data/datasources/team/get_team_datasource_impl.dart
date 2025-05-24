import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/team/get_team_datasource.dart';
import 'package:jackpot/domain/entities/resume_team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/resume_team_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetTeamDatasourceImpl implements IGetTeamDatasource {
  @override
  Future<Either<IJackExceptions, ResumeTeamEntity>> call(String teamId) async {
    final dio = Dio();

    try {
      final response =
          await dio.get('${JackEnvironment.apiUrl}team/getteam?id=$teamId',
              options: Options(
                headers: {
                  'accept': '*/*',
                },
              ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final team = ResumeTeamEntityMapper.fromJson(handledData);

      return Right(team);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
