import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/auth/create_user_datasource.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/auth/auth_repository.dart';

class CreateUserRepositoryImpl implements ICreateUserRepository {
  CreateUserRepositoryImpl({required this.datasource});

  ICreateUserDatasource datasource;
  @override
  Future<Either<IJackExceptions, bool>> call(NewUserEntity user) async {
    final response = await datasource(user);
    return response;
  }
}
