import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_bet_datasource.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/bet_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class CreateBetDatasourceImpl implements ICreateBetDatasource {
  @override
  Future<Either<IJackExceptions, bool>> call(BetEntity bet) async {
    final dio = Dio();
    final body = BetEntityMapper.toJson(bet);

    try {
      await dio.post('${JackEnvironment.apiUrl}betmade',
          data: body,
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      return const Right(true);
    } catch (e, data) {
      log('Erro ao tentar criar Bet: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
