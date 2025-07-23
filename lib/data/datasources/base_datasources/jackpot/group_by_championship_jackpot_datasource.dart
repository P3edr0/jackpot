import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGroupByChampionshipJackpotDatasource {
  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call();
}
