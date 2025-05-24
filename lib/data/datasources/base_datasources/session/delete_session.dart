import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class IDeleteSessionDatasource {
  Future<Either<IJackExceptions, bool>> call();
}
