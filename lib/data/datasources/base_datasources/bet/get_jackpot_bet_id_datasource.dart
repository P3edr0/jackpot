import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_resume_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetJackpotsBetIdDatasource {
  Future<Either<IJackExceptions, List<BetResumeEntity>>> call();
}
