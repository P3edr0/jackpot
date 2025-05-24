import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/championship/get_championship_datasource.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/resume_championship_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetChampionshipDatasourceImpl implements IGetChampionshipDatasource {
  @override
  Future<Either<IJackExceptions, ResumeChampionshipEntity>> call(
      String championshipId) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          '${JackEnvironment.apiUrl}championship/get?id=$championshipId',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final championship = ResumeChampionshipEntityMapper.fromJson(handledData);

      return Right(championship);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
