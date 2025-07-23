import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/bet_resume_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetBetMadeRepository {
  Future<Either<IJackExceptions, List<BetMadeEntity>>> call(
      String userDocument);
}

abstract class IGetJackpotBetIdRepository {
  Future<Either<IJackExceptions, List<BetResumeEntity>>> call();
}
