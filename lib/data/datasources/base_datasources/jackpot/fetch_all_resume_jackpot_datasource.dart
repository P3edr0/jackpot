import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IFetchAllResumeJackpotDatasource {
  Future<Either<IJackExceptions, List<ResumeJackpotEntity>>> call();
}
