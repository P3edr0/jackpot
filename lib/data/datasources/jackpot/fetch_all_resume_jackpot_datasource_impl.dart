import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/fetch_all_resume_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/resume_jackpot_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class FetchAllResumeJackpotDatasourceImpl
    implements IFetchAllResumeJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<ResumeJackpotEntity>>> call() async {
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
          .map((jackpot) => ResumeJackpotEntityMapper.fromJson(jackpot))
          .toList();

      return Right(jackpots);
    } catch (e, data) {
      log('Erro ao buscar todos os jackpots simplificados : $e \n $data');
      return Left(
          BadRequestJackException(message: 'Erro ao buscar dados dos jackpot'));
    }
  }
}
