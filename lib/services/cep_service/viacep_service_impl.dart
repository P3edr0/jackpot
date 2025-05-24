import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/address_mapper.dart';
import 'package:jackpot/services/cep_service/cep_service.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class ViaCepServiceImpl implements CepService {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();
  @override
  Future<Either<IJackExceptions, AddressEntity>> call(String cep) async {
    try {
      final dio = Dio();
      if (tokenGenerator.bearerToken == null) {
        await tokenGenerator();
      }

      final response = await dio.get(
        'https://viacep.com.br/ws/$cep/json',
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data['erro'] == 'true') {
          return Left(
              BadRequestJackException(message: "Falha ao buscar dados do CEP"));
        }
        final address = AddressMapper.fromJson(data);
        final internalResponse = await _getCityId(address.ibgeCode!);
        return internalResponse.fold((exception) {
          log('Erro: ${exception.message}');
          return Left(BadRequestJackException(
              message:
                  response.statusMessage ?? "Falha ao buscar dados da cidade"));
        }, (cityId) {
          address.cityCode = cityId;
          return Right(address);
        });
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(
            message: response.statusMessage ?? "Falha ao buscar dados do CEP"));
      }
    } catch (e) {
      log('Erro: ${e.toString()}');
      return Left(
          BadRequestJackException(message: "Falha ao buscar dados do CEP"));
    }
  }

  Future<Either<IJackExceptions, int>> _getCityId(String ibgeCode) async {
    try {
      final dio = Dio();
      final response = await dio.get(
          '${JackEnvironment.apiUzerpass}rest/v1/cidades/ibge/$ibgeCode',
          options: Options(headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": tokenGenerator.bearerToken!.generate(),
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        final cityCode = data.first['id'];

        return Right(cityCode);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(
            message: response.statusMessage ?? "Falha ao buscar dados do CEP"));
      }
    } catch (e) {
      log('Erro: ${e.toString()}');
      return Left(
          BadRequestJackException(message: "Falha ao buscar dados do CEP"));
    }
  }
}
