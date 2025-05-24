import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetJackpotDatasource {
  Future<Either<IJackExceptions, JackpotEntity>> call(String jackpots);
}
