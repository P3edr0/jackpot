import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_jackpot_bet_id_datasource.dart';
import 'package:jackpot/domain/entities/bet_resume_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/bet_resume_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetJackpotBetIdDatasourceImpl implements IGetJackpotsBetIdDatasource {
  @override
  Future<Either<IJackExceptions, List<BetResumeEntity>>> call() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          '${JackEnvironment.apiUrl}bet/fetchall', //userDocument',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final handledListData = List<Map<String, dynamic>>.from(data);
      final bets = handledListData
          .map((map) => BetResumeEntityMapper.fromJson(map))
          .toList();

      return Right(bets);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Erro ao buscar dados do Bets realizadas'));
    }
  }
}
