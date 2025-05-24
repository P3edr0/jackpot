import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/check_credential_datasource.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/user_mapper.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

class CheckCredentialDatasource implements ICheckCredentialDatasource {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();
  @override
  Future<Either<IJackExceptions, UserEntity>> call(
      String credential, CredentialType type) async {
    final dio = Dio();

    if (tokenGenerator.bearerToken == null) {
      await tokenGenerator();
    }
    String query;
    if (type.isEmail) {
      query = 'email=$credential';
    } else {
      query = 'documento=$credential';
    }
    if (tokenGenerator.bearerToken == null) {
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
    log(tokenGenerator.bearerToken!.generate(), name: "Token gerado");
    try {
      final response = await dio.get(
          '${JackEnvironment.apiUzerpass}rest/v1/usuarios/existente?$query',
          options: Options(headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": tokenGenerator.bearerToken!.generate()
          }));

      if (response.statusCode == 200) {
        final user = UserMapper.fromJson(response.data);
        return Right(user);
      } else {
        log('Erro: ${response.statusMessage}/n Code:${response.statusCode}');
        return Left(
            BadRequestJackException(message: 'Falha ao fazer a autenticação'));
      }
    } catch (e) {
      final exception = e as DioException;
      if (exception.type == DioExceptionType.badResponse) {
        String handledException;
        try {
          handledException = exception.response!.data!['erro'];
        } catch (e) {
          handledException = 'Falha ao fazer a autenticação';
        }
        return Left(BadRequestJackException(message: handledException));
      }
      log('Exception:${e.toString()}');
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
  }
}
