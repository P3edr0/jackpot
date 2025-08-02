import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IFetchAllAwardsRepository {
  Future<Either<IJackExceptions, List<AwardEntity>>> call();
}
