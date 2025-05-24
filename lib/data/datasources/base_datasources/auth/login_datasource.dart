import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class ILoginDatasource {
  Future<Either<IJackExceptions, NewUserEntity>> call(
      String credential, String password);
}
