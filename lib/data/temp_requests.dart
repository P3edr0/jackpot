import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/mappers/championship_entity_mapper.dart';
import 'package:jackpot/domain/mappers/jackpot_entity_mapper.dart';
import 'package:jackpot/domain/mappers/team_entity_mapper.dart';

class TempRequests {
  static Future<List<JackpotEntity>> fetchAllJacks() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://hml-apijackpot.uzerpass.com.br/api/jackpot/fetchall',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);

      final idLists = lists.map((map) => map['id']).toList();
      final handledIdList = List<int>.from(idLists);
      List<Map<String, dynamic>> jackDatas = [];
      for (var id in handledIdList) {
        final response = await dio.get(
            'https://hml-apijackpot.uzerpass.com.br/api/jackpot/getjackpot?id=$id',
            options: Options(
              headers: {
                'accept': '*/*',
              },
            ));

        final newData = response.data as Map<String, dynamic>;
        jackDatas.add(newData);
      }
      log(data.toString());
      final jackpots =
          jackDatas.map((data) => JackpotEntityMapper.fromJson(data)).toList();

      return jackpots;
    } catch (e) {
      log('Erro ao realizar a requisição: $e');
    }
    return [];
  }

  static Future<List<TeamEntity>> fetchAllTeams() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://hml-apijackpot.uzerpass.com.br/api/team/fetchall',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);

      final idLists = lists.map((map) => map['id']).toList();
      final handledIdList = List<int>.from(idLists);
      List<Map<String, dynamic>> TeamDatas = [];
      for (var id in handledIdList) {
        final response = await dio.get(
            'https://hml-apijackpot.uzerpass.com.br/api/team/getteam?id=$id',
            options: Options(
              headers: {
                'accept': '*/*',
              },
            ));

        final newData = response.data as Map<String, dynamic>;
        TeamDatas.add(newData);
      }
      log(data.toString());
      final teams =
          TeamDatas.map((data) => TeamEntityMapper.fromJson(data)).toList();

      return teams;
    } catch (e) {
      log('Erro ao realizar a requisição: $e');
    }
    return [];
  }

  static Future<List<Object>> fetchAllChampionships() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://hml-apijackpot.uzerpass.com.br/api/championship/fetchall',
          options: Options(
            headers: {
              'accept': '*/*',
            },
          ));

      final data = response.data;

      final lists = List<Map<String, dynamic>>.from(data);

      final idLists = lists.map((map) => map['id']).toList();
      final handledIdList = List<int>.from(idLists);
      List<Map<String, dynamic>> championshipDatas = [];
      for (var id in handledIdList) {
        final response = await dio.get(
            'https://hml-apijackpot.uzerpass.com.br/api/championship/get?id=$id',
            options: Options(
              headers: {
                'accept': '*/*',
              },
            ));

        final newData = response.data as Map<String, dynamic>;
        championshipDatas.add(newData);
      }
      log(data.toString());
      final championships = championshipDatas
          .map((data) => ChampionshipEntityMapper.fromJson(data))
          .toList();

      return championships;
    } catch (e) {
      log('Erro ao realizar a requisição: $e');
    }
    return [];
  }
}
