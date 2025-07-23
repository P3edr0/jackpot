import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_bet_made_datasource.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/bet_made_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetBetMadeDatasourceImpl implements IGetBetMadeDatasource {
  @override
  Future<Either<IJackExceptions, List<BetMadeEntity>>> call(
      String userDocument) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          '${JackEnvironment.apiUrl}betmade/fetchbycpf?cpf=$userDocument',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final handledListData = List<Map<String, dynamic>>.from(data);
      final bets = handledListData
          .map((map) => BetMadeEntityMapper.fromJson(map))
          .toList();

      return Right(bets);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Erro ao buscar dados do Bets realizadas'));
    }
  }
}
