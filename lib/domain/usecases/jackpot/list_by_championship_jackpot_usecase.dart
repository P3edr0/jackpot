import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class ListByChampionshipJackpotUsecase {
  ListByChampionshipJackpotUsecase({
    required this.repository,
  });
  IListByChampionshipJackpotRepository repository;

  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String championshipId) async {
    if (championshipId.trim().isEmpty) {
      return Left(
          DataException(message: "O id do campeonato não pode ser vazio"));
    }
    return repository(championshipId);
  }
}
