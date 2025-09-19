import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class FetchAllResumeJackpotUsecase {
  FetchAllResumeJackpotUsecase({
    required this.repository,
  });
  IFetchAllResumeJackpotRepository repository;

  Future<Either<IJackExceptions, List<ResumeJackpotEntity>>> call() async {
    return repository();
  }
}
