import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class ICreateSessionRepository {
  Future<Either<IJackExceptions, bool>> call(SessionEntity session);
}

abstract class IGetSessionRepository {
  Future<Either<IJackExceptions, SessionEntity?>> call();
}

abstract class IDeleteSessionRepository {
  Future<Either<IJackExceptions, bool>> call();
}
