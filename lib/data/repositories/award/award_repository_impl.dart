import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/award/fetch_all_awards_datasource.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/award/award_repository.dart';

class FetchAllAwardsRepositoryImpl implements IFetchAllAwardsRepository {
  FetchAllAwardsRepositoryImpl({required this.datasource});
  IFetchAllAwardsDatasource datasource;

  @override
  Future<Either<IJackExceptions, List<AwardEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}
