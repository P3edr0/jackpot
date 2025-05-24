import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/championship/get_championship_datasource.dart';
import 'package:jackpot/domain/entities/resume_championship_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/championship/championship_repository.dart';

class GetChampionshipRepositoryImpl implements IGetChampionshipRepository {
  GetChampionshipRepositoryImpl({required this.datasource});
  IGetChampionshipDatasource datasource;

  @override
  Future<Either<IJackExceptions, ResumeChampionshipEntity>> call(
      String championshipId) async {
    final response = await datasource.call(championshipId);
    return response;
  }
}
