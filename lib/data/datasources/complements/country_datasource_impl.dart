import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/complements/country_datasource.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/country_mapper.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class CountryDatasourceImpl implements ICountryDatasource {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();
  @override
  Future<Either<IJackExceptions, List<CountryEntity>>> call() async {
    final dio = Dio();

    if (tokenGenerator.bearerToken == null) {
      await tokenGenerator();
    }

    if (tokenGenerator.bearerToken == null) {
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
    log(tokenGenerator.bearerToken!.generate(), name: "Token gerado");
    try {
      final response =
          await dio.get('${JackEnvironment.apiUzerpass}rest/v1/paises',
              options: Options(headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": tokenGenerator.bearerToken!.generate()
              }));

      if (response.statusCode == 200) {
        final countries = List<Map<String, dynamic>>.from(response.data);
        final handledCountries = countries
            .map((country) => CountryMapper.fromJson(country))
            .toList();
        return Right(handledCountries);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(
            BadRequestJackException(message: 'Falha ao fazer a autenticação'));
      }
    } catch (e) {
      log('Exception:${e.toString()}');
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
  }
}
