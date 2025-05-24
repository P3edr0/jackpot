import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class ListByTeamJackpotUsecase {
  ListByTeamJackpotUsecase({
    required this.repository,
  });
  IListByTeamJackpotRepository repository;

  Future<Either<IJackExceptions, List<PreviewJackpotEntity>>> call(
      String teamId) async {
    if (teamId.trim().isEmpty) {
      return Left(DataException(message: "O id do time não pode ser vazio"));
    }
    return repository(teamId);
  }
}
