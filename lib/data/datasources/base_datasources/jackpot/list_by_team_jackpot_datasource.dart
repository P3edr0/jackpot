import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IListByTeamJackpotDatasource {
  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String teamId);
}
