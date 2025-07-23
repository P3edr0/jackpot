import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/bet_resume_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/bet/bet_repository.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class GetBetMadeUsecase {
  GetBetMadeUsecase(
      {required this.repository, required this.jackpotBetIdRepository});
  IGetBetMadeRepository repository;
  IGetJackpotBetIdRepository jackpotBetIdRepository;

  Future<Either<IJackExceptions, List<BetMadeEntity>>> call(
      String userDocument) async {
    if (userDocument.trim().isEmpty) {
      return Left(
          DataException(message: "O documento do usuário não pode ser vazio"));
    }
    final response = await repository(userDocument);
    List<BetResumeEntity> betsResume = [];

    return response.fold(
      (exception) {
        return Left(exception);
      },
      (betsMade) async {
        final newResponse = await jackpotBetIdRepository();
        return newResponse.fold(
          (error) {
            return Left(error);
          },
          (newBetsResume) {
            betsResume = newBetsResume;

            for (var bet in betsMade) {
              final betResume = betsResume
                  .firstWhere((element) => element.betId == bet.betId);
              bet.jackpotId = betResume.jackpotId;
              bet.expireAt = betResume.expiresAt;
              final today = DateTime.now();

              if (today.isAfter(bet.expireAt!)) {
                bet.status = BetStatus.closed;
              }
            }
            return Right(betsMade);
          },
        );
      },
    );
  }
}
