import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/resume_team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetTeamDatasource {
  Future<Either<IJackExceptions, ResumeTeamEntity>> call(String teamId);
}
