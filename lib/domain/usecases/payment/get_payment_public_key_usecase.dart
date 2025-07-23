import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';

class GetPaymentPublicKeyUsecase {
  GetPaymentPublicKeyUsecase({required this.repository});
  IGetPaymentPublicKeyRepository repository;

  Future<Either<IJackExceptions, String>> call() async {
    return repository();
  }
}
