import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/session/delete_session.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/session/session_repository.dart';

class DeleteSessionRepositoryImpl implements IDeleteSessionRepository {
  DeleteSessionRepositoryImpl(this.datasource);
  IDeleteSessionDatasource datasource;
  @override
  Future<Either<IJackExceptions, bool>> call() async {
    final response = await datasource.call();
    return response;
  }
}
