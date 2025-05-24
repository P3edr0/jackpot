import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class ICreateUserDatasource {
  Future<Either<IJackExceptions, bool>> call(NewUserEntity user);
}
