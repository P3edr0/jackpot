import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class ICreateBetDatasource {
  Future<Either<IJackExceptions, bool>> call(BetEntity bet);
}
