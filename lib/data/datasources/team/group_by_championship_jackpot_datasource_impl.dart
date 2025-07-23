import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/group_by_championship_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/championship_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GroupByChampionshipJackpotDatasourceImpl
    implements IGroupByChampionshipJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('${JackEnvironment.apiUrl}jackpot/groupbychampionship',
              options: Options(
                headers: {
                  'accept': '*/*',
                },
              ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final championships =
          lists.map((data) => ChampionshipEntityMapper.fromJson(data)).toList();

      final championshipIds =
          championships.map((championship) => championship.id).toSet();

      List<ChampionshipEntity> filteredChampionship = [];

      for (var element in championshipIds) {
        final newChampionship = championships
            .firstWhere((championship) => championship.id == element);
        filteredChampionship.add(newChampionship);
      }

      return Right(filteredChampionship);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados do jackpot'));
    }
  }
}
