import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/login_datasource.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/new_user_mapper.dart';
import 'package:jackpot/services/mappers/token_mapper.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();
  @override
  Future<Either<IJackExceptions, NewUserEntity>> call(
      String credential, String password) async {
    final dio = Dio();

    if (tokenGenerator.bearerToken == null) {
      await tokenGenerator();
    }

    if (tokenGenerator.bearerToken == null) {
      return Left(
          BadRequestJackException(message: 'Senha ou usuário inválido.'));
    }
    log(tokenGenerator.basicToken!.generate(), name: "Token gerado");
    log('${JackEnvironment.apiUzerpass}oauth/token', name: "URL");
    log(
        json.encode({
          "grant_type": "password",
          "username": credential,
          "password": password
        }).toString(),
        name: "Json");
    try {
      final response = await dio.post(
          '${JackEnvironment.apiUzerpass}oauth/token',
          data: json.encode({
            "grant_type": "password",
            "username": credential,
            "password": password
          }),
          options: Options(headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization":
                "Basic YTcxNWJjNzVhMmFiZDdiYTRhYTVhMmZiMjc3MTc3YzY6NTU2ZGUzN2M4MTI1OWJiY2ZlZjhlNWYwNjQwOTFmMWI=", //tokenGenerator.basicToken!.generate(),
            "deviceid": JackEnvironment.deviceId
          }));

      if (response.statusCode == 200) {
        final token = TokenMapper.fromJson(response.data);
        tokenGenerator.accessToken = token;
        var headers = {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': token.generate(),
          'X-App-Context': 'bipfut',
        };
        final internalResponse = await dio.get(
          '${JackEnvironment.apiUzerpass}rest/v1/usuarios',
          options: Options(
            headers: headers,
          ),
        );
        if (internalResponse.statusCode == 200) {
          log(internalResponse.data.toString());
          final user = NewUserMapper.fromJson(internalResponse.data);

          log("Sucesso");
          return Right(user);
        }

        return Left(
            BadRequestJackException(message: 'Senha ou usuário inválido.'));
      } else if (response.statusCode == 403) {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(message: 'Senha incorreta'));
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(
            BadRequestJackException(message: 'Senha ou usuário inválido.'));
      }
    } catch (e) {
      log('Exception:${e.toString()}');
      return Left(
          BadRequestJackException(message: 'Senha ou usuário inválido.'));
    }
  }
}
