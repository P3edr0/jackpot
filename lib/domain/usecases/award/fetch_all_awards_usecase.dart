import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/award/award_repository.dart';

class FetchAllAwardsUsecase {
  FetchAllAwardsUsecase({
    required this.repository,
  });
  IFetchAllAwardsRepository repository;

  Future<Either<IJackExceptions, List<AwardEntity>>> call() async {
    return repository();
  }
}
