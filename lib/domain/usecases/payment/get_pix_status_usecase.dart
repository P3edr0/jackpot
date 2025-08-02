import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';
import 'package:jackpot/shared/utils/enums/payment_status.dart';

class GetPixStatusUsecase {
  GetPixStatusUsecase({required this.repository});
  IGetPixStatusRepository repository;

  Future<Either<IJackExceptions, PaymentStatus>> call(String id) async {
    if (id.trim().isEmpty) {
      return Left(DataException(message: "O Id do pix não pode ser vazio"));
    }

    return repository(id);
  }
}
