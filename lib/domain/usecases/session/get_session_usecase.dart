import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class GetSessionUseCase {
  final IGetSessionRepository repository;

  GetSessionUseCase({
    required this.repository,
  });

  Future<Either<IJackExceptions, SessionEntity?>> call() async {
    return repository();
  }
}
