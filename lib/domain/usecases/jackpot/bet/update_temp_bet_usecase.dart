import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class UpdateTempBetUsecase {
  UpdateTempBetUsecase({
    required this.repository,
  });
  IUpdateTempBetRepository repository;

  Future<Either<IJackExceptions, bool>> call(
      List<TemporaryBetEntity> tempBets) async {
    return repository(tempBets);
  }
}
