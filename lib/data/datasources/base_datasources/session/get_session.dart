import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetSessionDatasource {
  Future<Either<IJackExceptions, SessionEntity?>> call();
}
