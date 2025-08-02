import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IFetchExtraJackpotDatasource {
  Future<Either<IJackExceptions, List<ExtraJackpotEntity>>> call();
}
