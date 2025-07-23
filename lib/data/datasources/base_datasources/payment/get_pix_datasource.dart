import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IGetPixDatasource {
  Future<Either<IJackExceptions, PixEntity>> call(PaymentOrderEntity order);
}
