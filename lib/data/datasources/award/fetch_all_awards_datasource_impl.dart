import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/award/fetch_all_awards_datasource.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/award_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class FetchAllAwardsDatasourceImpl implements IFetchAllAwardsDatasource {
  @override
  Future<Either<IJackExceptions, List<AwardEntity>>> call() async {
    final dio = Dio();
    try {
      final response = await dio.get('${JackEnvironment.apiUrl}award/fetchall',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final awards =
          lists.map((award) => AwardEntityMapper.fromJson(award)).toList();

      return Right(awards);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados dos Prêmios'));
    }
  }
}
