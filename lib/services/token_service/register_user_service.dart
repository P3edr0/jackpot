import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/services/entities/register_entity.dart';
import 'package:jackpot/services/mappers/register_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class RegisterUserService {
  Future<Either<IJackExceptions, RegisterEntity>> call() async {
    try {
      final dio = Dio();
      final response = await dio.post(
          '${JackEnvironment.apiUzerpass}rest/clientes',
          data: json.encode({
            "nome": "APP flutter",
            "tipo": "app-venda",
            "deviceid": JackEnvironment.deviceId
          }),
          options: Options(
            headers: {
              "Content-type": "application/json; charset=UTF-8",
            },
          ));
      if (response.statusCode == 200) {
        var data = response.data;

        final register = RegisterMapper.fromJson(data);

        return Right(register);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(BadRequestJackException(
            message: response.statusMessage ?? "Falha ao registrar usuário"));
      }
    } catch (e) {
      log('Erro: ${e.toString()}');
      return Left(
          BadRequestJackException(message: "Falha ao registrar usuário"));
    }
  }
}
