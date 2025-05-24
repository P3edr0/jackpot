import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';

abstract class ICheckCredentialDatasource {
  Future<Either<IJackExceptions, UserEntity>> call(
      String credential, CredentialType type);
}
