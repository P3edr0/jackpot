import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/team/get_team_datasource.dart';
import 'package:jackpot/domain/entities/resume_team_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/team/team_repository.dart';

class GetTeamRepositoryImpl implements IGetTeamRepository {
  GetTeamRepositoryImpl({required this.datasource});
  IGetTeamDatasource datasource;

  @override
  Future<Either<IJackExceptions, ResumeTeamEntity>> call(String teamId) async {
    final response = await datasource.call(teamId);
    return response;
  }
}
