import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class DeleteSessionUseCase {
  final IDeleteSessionRepository repository;

  DeleteSessionUseCase({
    required this.repository,
  });

  Future<Either<IJackExceptions, bool>> call() async {
    return repository();
  }
}
