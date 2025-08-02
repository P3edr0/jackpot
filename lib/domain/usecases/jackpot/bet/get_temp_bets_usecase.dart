import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class GetTempBetsUsecase {
  GetTempBetsUsecase({
    required this.repository,
  });
  IGetTempBetRepository repository;

  Future<Either<IJackExceptions, List<TemporaryBetEntity>>> call(
      String userDocument) async {
    return repository(userDocument);
  }
}
