import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetChampionshipRepository {
  Future<Either<IJackExceptions, ResumeChampionshipEntity>> call(
      String championshipId);
}
