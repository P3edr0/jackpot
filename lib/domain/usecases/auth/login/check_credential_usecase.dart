import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

class CheckCredentialUsecase {
  CheckCredentialUsecase({required this.repository});
  ICheckCredentialRepository repository;
  Future<Either<IJackExceptions, UserEntity>> call(
      String credential, CredentialType type) async {
    if (credential.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }
    if (type.isDocument && credential.length < 11) {
      return Left(DataException(message: 'Credencial inválida.'));
    }
    return await repository(credential, type);
  }
}
