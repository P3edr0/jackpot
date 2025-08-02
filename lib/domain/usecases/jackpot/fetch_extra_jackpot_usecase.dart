import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class FetchExtraJackpotUsecase {
  FetchExtraJackpotUsecase({
    required this.repository,
  });
  IFetchExtraJackpotRepository repository;

  Future<Either<IJackExceptions, List<ExtraJackpotEntity>>> call() async {
    return repository();
  }
}
