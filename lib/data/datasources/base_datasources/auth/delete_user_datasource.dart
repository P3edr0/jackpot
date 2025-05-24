import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IDeleteUserDatasource {
  Future<Either<IJackExceptions, bool>> call(String userId);
}
