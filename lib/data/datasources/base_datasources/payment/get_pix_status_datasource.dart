import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/shared/utils/enums/payment_status.dart';

abstract class IGetPixStatusDatasource {
  Future<Either<IJackExceptions, PaymentStatus>> call(String id);
}
