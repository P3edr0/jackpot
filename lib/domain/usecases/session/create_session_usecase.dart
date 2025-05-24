import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class CreateSessionUseCase {
  final ICreateSessionRepository repository;

  CreateSessionUseCase({
    required this.repository,
  });

  Future<Either<IJackExceptions, bool>> call(SessionEntity session) async {
    if (session.image.trim().isEmpty) {
      return Left(DataException(message: 'A imagem não pode ser vazio'));
    }
    if (session.credential.trim().isEmpty) {
      return Left(DataException(message: 'A credencial não pode ser vazio'));
    }
    if (session.password.trim().isEmpty) {
      return Left(DataException(message: 'A senha não pode ser vazia'));
    }

    return repository(session);
  }
}
