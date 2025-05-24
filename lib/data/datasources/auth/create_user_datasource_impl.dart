import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/create_user_datasource.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/new_user_mapper.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class CreateUserDatasourceImpl implements ICreateUserDatasource {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();

  @override
  Future<Either<IJackExceptions, bool>> call(NewUserEntity newUser) async {
    final dio = Dio();

    if (tokenGenerator.bearerToken == null) {
      await tokenGenerator();
    }

    if (tokenGenerator.bearerToken == null) {
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
    final newUserData = NewUserMapper.toJson(newUser);
    log(tokenGenerator.bearerToken!.generate(), name: "Token gerado");
    log('${JackEnvironment.apiUzerpass}oauth/token', name: "URL");
    log(json.encode(newUserData).toString(), name: "Json");
    try {
      final response =
          await dio.post('${JackEnvironment.apiUzerpass}rest/v1/usuarios',
              data: json.encode(newUserData),
              options: Options(headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": tokenGenerator.bearerToken!.generate(),
                "idDispositivo": '',
                "tokenDispositivo": '',
                "deviceid": JackEnvironment.deviceId
              }));

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['sucesso']) {
          return const Right(true);
        }
      }
      return Left(BadRequestJackException(message: 'Senha incorreta'));
    } catch (e) {
      log('Exception:${e.toString()}');
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
  }
}
