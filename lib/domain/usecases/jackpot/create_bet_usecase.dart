import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class CreateBetUsecase {
  CreateBetUsecase({
    required this.repository,
  });
  ICreateBetRepository repository;

  Future<Either<IJackExceptions, bool>> call(BetEntity bet) async {
    return repository(bet);
  }
}
