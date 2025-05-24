import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/list_by_championship_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/preview_jackpot_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class ListByChampionshipJackpotDatasourceImpl
    implements IListByChampionshipJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String championshipId) async {
    final dio = Dio();
    try {
      final response = await dio.get(
          '${JackEnvironment.apiUrl}jackpot/listbychampionship/$championshipId',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final championshipsJackpot = lists
          .map((championship) =>
              PreviewJackpotEntityMapper.fromJson(championship))
          .toList();

      return Right(championshipsJackpot);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
