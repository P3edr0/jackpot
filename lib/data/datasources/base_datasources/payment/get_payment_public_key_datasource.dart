import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetPaymentPublicKeyDatasource {
  Future<Either<IJackExceptions, String>> call();
}
