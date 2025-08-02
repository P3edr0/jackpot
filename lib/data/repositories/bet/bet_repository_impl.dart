import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_bet_made_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/bet/get_jackpot_bet_id_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/delete_temp_bets_datasource.dart';
import 'package:jackpot/domain/entities/bet_made_entity.dart';
import 'package:jackpot/domain/entities/bet_resume_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/bet/bet_repository.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';

class GetBetMadeRepositoryImpl implements IGetBetMadeRepository {
  GetBetMadeRepositoryImpl({required this.datasource});
  IGetBetMadeDatasource datasource;
  @override
  Future<Either<IJackExceptions, List<BetMadeEntity>>> call(
      String userDocument) async {
    final response = await datasource.call(userDocument);
    return response;
  }
}

class GetJackpotBetIdRepositoryImpl implements IGetJackpotBetIdRepository {
  GetJackpotBetIdRepositoryImpl({required this.datasource});
  IGetJackpotsBetIdDatasource datasource;
  @override
  Future<Either<IJackExceptions, List<BetResumeEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}

class DeleteTempBetRepositoryImpl implements IDeleteTempBetRepository {
  DeleteTempBetRepositoryImpl({required this.datasource});
  IDeleteTempBetDatasource datasource;

  @override
  Future<Either<IJackExceptions, bool>> call(
      String userDocument, String paymentId) async {
    final response = await datasource(userDocument, paymentId);
    return response;
  }
}
