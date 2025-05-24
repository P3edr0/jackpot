import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/session/delete_session.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

class SecureStorageDeleteSession implements IDeleteSessionDatasource {
  @override
  Future<Either<IJackExceptions, bool>> call() async {
    const storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();

      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException(message: "Falha ao fazer logout"));
    }
  }
}
