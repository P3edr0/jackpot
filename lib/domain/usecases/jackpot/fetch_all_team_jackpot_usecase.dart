import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class FetchAllTeamJackpotUsecase {
  FetchAllTeamJackpotUsecase({
    required this.repository,
  });
  IFetchAllTeamJackpotRepository repository;

  Future<Either<IJackExceptions, List<TeamEntity>>> call() async {
    return repository();
  }
}
