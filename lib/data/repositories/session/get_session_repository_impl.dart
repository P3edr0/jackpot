import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/session/get_session.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class GetSessionRepositoryImpl implements IGetSessionRepository {
  GetSessionRepositoryImpl(this.datasource);
  IGetSessionDatasource datasource;
  @override
  Future<Either<IJackExceptions, SessionEntity?>> call() async {
    final response = await datasource.call();
    return response;
  }
}
