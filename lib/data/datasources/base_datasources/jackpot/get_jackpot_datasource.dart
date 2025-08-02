import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetJackpotDatasource {
  Future<Either<IJackExceptions, SportJackpotEntity>> call(String jackpots);
}
