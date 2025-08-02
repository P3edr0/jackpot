import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/extra/fetch_extra_jackpot_datasource.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

class FetchExtraJackpotDatasourceImpl implements IFetchExtraJackpotDatasource {
  @override
  Future<Either<IJackExceptions, List<ExtraJackpotEntity>>> call() async {
    final dio = Dio();
    //TODO: REMOVER MOCK DE LISTAGEM DE EXTRAS
    try {
      //   final response = await dio.get('${JackEnvironment.extraApiUrl}jackpots',
      //       options: Options(
      //         headers: {
      //           'accept': 'application/json',
      //         },
      //       ));

      //   final data = response.data;

      //   final lists = List<Map<String, dynamic>>.from(data);
      //   final extra =
      //       lists.map((element) => ExtraEntityMapper.fromJson(element)).toList();

      await Future.delayed(const Duration(seconds: 1));
      final extra = [
        ExtraJackpotEntity(
            banner: '',
            id: '1',
            dozensPerCard: 10,
            dozensPerChoice: 80,
            budgetValue: '2.99',
            logo: '',
            name: 'NATAL DA SORTE',
            state: 'MG',
            type: 'DEZENAS',
            description: '',
            endAt: DateTime.now()),
        ExtraJackpotEntity(
            banner: '',
            id: '2',
            dozensPerCard: 10,
            dozensPerChoice: 100,
            budgetValue: '3.99',
            logo: '',
            name: 'DEZENAS DA FORTUNA',
            state: 'RJ',
            type: 'DEZENAS',
            description: '',
            endAt: DateTime.now()),
        ExtraJackpotEntity(
            banner: '',
            id: '3',
            dozensPerCard: 5,
            dozensPerChoice: 80,
            budgetValue: '5.99',
            logo: '',
            name: 'QUINA DO DIA DOS NAMORADOS',
            state: 'SP',
            type: 'DEZENAS',
            description: '',
            endAt: DateTime.now()),
      ];

      return Right(extra);
    } catch (e, data) {
      log('Erro ao realizar a requisição: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Erro ao buscar dados do jackpot extra'));
    }
  }
}
