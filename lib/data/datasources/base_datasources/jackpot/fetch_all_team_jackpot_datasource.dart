import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IFetchAllTeamJackpotDatasource {
  Future<Either<IJackExceptions, List<TeamEntity>>> call();
}
