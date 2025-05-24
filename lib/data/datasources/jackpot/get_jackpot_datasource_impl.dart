import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/get_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/jackpot_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetJackpotDatasourceImpl implements IGetJackpotDatasource {
  @override
  Future<Either<IJackExceptions, JackpotEntity>> call(String jackpotId) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          '${JackEnvironment.apiUrl}jackpot/getjackpot?id=$jackpotId',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final jackpot = JackpotEntityMapper.fromJson(handledData);

      return Right(jackpot);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
