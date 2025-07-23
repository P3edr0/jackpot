import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';

class GetPixUsecase {
  GetPixUsecase({required this.repository});
  IGetPixRepository repository;

  Future<Either<IJackExceptions, PixEntity>> call(
      PaymentOrderEntity order) async {
    return repository(order);
  }
}
