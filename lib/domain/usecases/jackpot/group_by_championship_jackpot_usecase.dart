import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class GroupByChampionshipJackpotUsecase {
  GroupByChampionshipJackpotUsecase({
    required this.repository,
  });
  IGroupByChampionshipJackpotRepository repository;

  Future<Either<IJackExceptions, List<ChampionshipEntity>>> call() async {
    return repository();
  }
}
