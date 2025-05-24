import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/session/get_session.dart';
import 'package:jackpot/domain/entities/session_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/session_mapper.dart';

class SecureStorageGetSession implements IGetSessionDatasource {
  @override
  Future<Either<IJackExceptions, SessionEntity?>> call() async {
    const storage = FlutterSecureStorage();
    const key = 'login';
    try {
      String? response = await storage.read(key: key);
      if (response == null) {
        return const Right(null);
      }

      final newResponse = response
          .replaceAll(RegExp(r'\"\{'), "'{")
          .replaceAll(RegExp(r'\}\"'), "}'");
      final content = jsonDecode(newResponse);
      log(content.toString());
      final session = SessionMapper.fromJson(content);

      return Right(session);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException());
    }
  }
}
