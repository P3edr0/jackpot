import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetPixRepository {
  Future<Either<IJackExceptions, PixEntity>> call(PaymentOrderEntity order);
}

abstract class ICardPaymentRepository {
  Future<Either<IJackExceptions, String>> call(PaymentOrderEntity order);
}

abstract class IGetPixStatusRepository {
  Future<Either<IJackExceptions, bool>> call(String id);
}

abstract class IGetPaymentPublicKeyRepository {
  Future<Either<IJackExceptions, String>> call();
}
