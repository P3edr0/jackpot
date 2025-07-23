import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';

class GetPixStatusUsecase {
  GetPixStatusUsecase({required this.repository});
  IGetPixStatusRepository repository;

  Future<Either<IJackExceptions, bool>> call(String id) async {
    if (id.trim().isEmpty) {
      return Left(DataException(message: "O Id do pix não pode ser vazio"));
    }

    return repository(id);
  }
}
