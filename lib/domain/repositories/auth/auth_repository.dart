import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

abstract class ICheckCredentialRepository {
  Future<Either<IJackExceptions, UserEntity>> call(
      String credential, CredentialType type);
}

abstract class ICreateUserRepository {
  Future<Either<IJackExceptions, bool>> call(NewUserEntity user);
}

abstract class ILoginRepository {
  Future<Either<IJackExceptions, NewUserEntity>> call(
      String credential, String password);
}
