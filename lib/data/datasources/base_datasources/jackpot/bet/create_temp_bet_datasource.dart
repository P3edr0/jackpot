import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IUpdateTempBetDatasource {
  Future<Either<IJackExceptions, bool>> call(List<TemporaryBetEntity> tempBets);
}
