import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IDeleteTempBetDatasource {
  Future<Either<IJackExceptions, bool>> call(
      String userDocument, String paymentId, String jackpotId);
}
