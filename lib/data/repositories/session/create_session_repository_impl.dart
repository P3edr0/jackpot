import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/session/create_session.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class CreateSessionRepositoryImpl implements ICreateSessionRepository {
  CreateSessionRepositoryImpl(this.datasource);
  ICreateSessionDatasource datasource;
  @override
  Future<Either<IJackExceptions, bool>> call(SessionEntity session) async {
    final response = await datasource.call(session);
    return response;
  }
}
