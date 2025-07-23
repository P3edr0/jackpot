import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';

class CardPaymentUsecase {
  CardPaymentUsecase({required this.repository});
  ICardPaymentRepository repository;

  Future<Either<IJackExceptions, String>> call(PaymentOrderEntity order) async {
    return repository(order);
  }
}
