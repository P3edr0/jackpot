import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/services/entities/register_entity.dart';
import 'package:jackpot/services/entities/token_entity.dart';
import 'package:jackpot/services/mappers/token_mapper.dart';
import 'package:jackpot/services/token_service/register_user_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GenerateGenericTokenService {
  GenerateGenericTokenService._();
  factory GenerateGenericTokenService.instance() {
    _instance ??= GenerateGenericTokenService._();

    return _instance!;
  }

  static GenerateGenericTokenService? _instance;
  TokenEntity? accessToken;
  TokenEntity? bearerToken;
  TokenEntity? basicToken;
  Future<Either<IJackExceptions, TokenEntity>> call() async {
    final RegisterUserService registerUserService = RegisterUserService();
    final register = await registerUserService();
    RegisterEntity? baseToken;
    IJackExceptions? exception;

    register.fold((error) {
      exception = error;
    }, (value) {
      baseToken = value;
    });
    if (exception != null) return Left(exception!);

    var utf8Text = utf8.encode(baseToken!.generate());

    final base64Credentials = base64.encode(utf8Text);
    log(base64Credentials, name: 'Basic');
    basicToken = TokenEntity(aux: 'Basic', token: base64Credentials);
    try {
      final dio = Dio();
      final response =
          await dio.post('${JackEnvironment.apiUzerpass}oauth/token',
              data: json.encode({"grant_type": "client_credentials"}),
              options: Options(
                headers: {
                  "Content-type": "application/json; charset=UTF-8",
                  "Authorization": "Basic $base64Credentials",
                  "deviceid": JackEnvironment.deviceId
                },
              ));
      if (response.statusCode == 200) {
        var data = response.data;

        final token = TokenMapper.fromJson(data);
        bearerToken = token;
        return Right(token);
      } else {
        bearerToken = null;
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(message: response.statusMessage!));
      }
    } catch (e) {
      bearerToken = null;

      log('Erro: ${e.toString()}');
      return Left(
          BadRequestJackException(message: "Falha ao registrar usuário"));
    }
  }
}
