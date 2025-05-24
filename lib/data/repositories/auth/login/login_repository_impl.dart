import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/check_credential_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/login_datasource.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

class CheckCredentialRepositoryImpl implements ICheckCredentialRepository {
  CheckCredentialRepositoryImpl({required this.datasource});

  ICheckCredentialDatasource datasource;
  @override
  Future<Either<IJackExceptions, UserEntity>> call(
      String credential, CredentialType type) async {
    final response = await datasource(credential, type);
    return response;
  }
}

class LoginRepositoryImpl implements ILoginRepository {
  LoginRepositoryImpl({required this.datasource});

  ILoginDatasource datasource;
  @override
  Future<Either<IJackExceptions, NewUserEntity>> call(
      String credential, String password) async {
    final response = await datasource(credential, password);
    return response;
  }
}
