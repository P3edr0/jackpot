import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';

class CreateUserUsecase {
  CreateUserUsecase({required this.repository});
  ICreateUserRepository repository;
  Future<Either<IJackExceptions, bool>> call(NewUserEntity user) async {
    if (user.name!.trim().isEmpty) {
      return Left(DataException(message: 'Nome não pode ser vazio.'));
    }
    if (user.document!.trim().isEmpty) {
      return Left(DataException(message: 'Documento não pode ser vazio.'));
    }

    return await repository(user);
  }
}
