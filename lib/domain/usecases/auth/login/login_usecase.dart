import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';

class LoginUsecase {
  LoginUsecase({required this.repository});
  ILoginRepository repository;
  Future<Either<IJackExceptions, NewUserEntity>> call(
      String credential, String password) async {
    if (credential.trim().isEmpty) {
      return Left(DataException(message: 'Credencial inválida.'));
    }
    if (password.trim().isEmpty) {
      return Left(DataException(message: 'Senha inválida.'));
    }

    return await repository(credential, password);
  }
}
