import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class DeleteTempBetUsecase {
  DeleteTempBetUsecase({
    required this.repository,
  });
  IDeleteTempBetRepository repository;

  Future<Either<IJackExceptions, bool>> call(
      {required String userDocument, required String paymentId}) async {
    return repository(userDocument, paymentId);
  }
}
