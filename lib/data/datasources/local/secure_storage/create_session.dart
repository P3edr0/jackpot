import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/session/create_session.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

class SecureStorageCreateSession implements ICreateSessionDatasource {
  @override
  Future<Either<IJackExceptions, bool>> call(SessionEntity session) async {
    const storage = FlutterSecureStorage();
    const key = 'login';
    try {
      await storage.deleteAll();
      await storage.write(key: key, value: session.toString());
      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException());
    }
  }
}
