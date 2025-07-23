import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetBetMadeDatasource {
  Future<Either<IJackExceptions, List<BetMadeEntity>>> call(
      String userDocument);
}
