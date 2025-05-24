import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/mappers/championship_entity_mapper.dart';
import 'package:jackpot/domain/mappers/resume_jackpot_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class TempRequests {
  static Future<List<ResumeJackpotEntity>> fetchAllJacks() async {
    final dio = Dio();

    try {
      final response =
          await dio.get('${JackEnvironment.apiUrl}jackpot/fetchall',
              options: Options(
                headers: {
                  'accept': '*/*',
                },
              ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);
      final jackpots = lists
          .map((data) => ResumeJackpotEntityMapper.fromJson(data))
          .toList();

      return jackpots;
    } catch (e) {
      log('Erro ao realizar a requisição: $e');
    }
    return [];
  }

  static Future<List<Object>> fetchAllChampionships() async {
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

      return filteredChampionship;
    } catch (e, stack) {
      log('Erro ao realizar a requisição: $e\n $stack');
    }
    return [];
  }
}
