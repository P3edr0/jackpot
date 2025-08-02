import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/get_temp_bets_datasource.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/temp_bet_entity_mapper.dart';

class SecureStorageGetTempBets implements IGetTempBetsDatasource {
  @override
  Future<Either<IJackExceptions, List<TemporaryBetEntity>>> call(
      String userDocument) async {
    const storage = FlutterSecureStorage();
    final key = userDocument;
    try {
      String? response = await storage.read(key: key);
      if (response == null) {
        return const Right([]);
      }

      if (response.startsWith('{[') && response.endsWith(']}')) {
        final withoutBraces = response.substring(1, response.length - 1);
        final jsonString = withoutBraces;

        final List<dynamic> contents = jsonDecode(jsonString);
        final temporaryBets = contents
            .map((content) => TempBetEntityMapper.fromJson(content))
            .toList();

        return Right(temporaryBets);
      } else {
        return const Right([]);
      }
    } catch (e, stack) {
      log('Erro: $e Stack: $stack');
      return Left(BadRequestJackException());
    }
  }
}
