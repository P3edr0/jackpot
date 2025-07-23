import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:jackpot/data/datasources/base_datasources/auth/delete_user_datasource.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class DeleteUserDatasourceImpl implements IDeleteUserDatasource {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();

  @override
  Future<Either<IJackExceptions, bool>> call(String userId) async {
    if (tokenGenerator.bearerToken == null) {
      await tokenGenerator();
    }

    if (tokenGenerator.bearerToken == null) {
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }

    try {
      final response = await http.delete(
        Uri.parse('${JackEnvironment.apiUzerpass}rest/v1/usuarios/$userId'),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          "Authorization": tokenGenerator.accessToken!.generate()
        },
      );
      if (response.statusCode == 204) {
        return const Right(true);
      } else {
        return Left(BadRequestJackException(message: 'Falha ao deletar conta'));
      }
    } catch (e) {
      log('Exception:${e.toString()}');
      return Left(
          BadRequestJackException(message: 'Falha ao fazer a autenticação'));
    }
  }
}
