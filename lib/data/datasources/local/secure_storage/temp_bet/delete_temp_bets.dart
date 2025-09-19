import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/delete_temp_bets_datasource.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/temp_bet_entity_mapper.dart';

class SecureStorageDeleteTempBet implements IDeleteTempBetDatasource {
  @override
  Future<Either<IJackExceptions, bool>> call(
      String userDocument, String paymentId, String jackpotId) async {
    const storage = FlutterSecureStorage();
    final key = userDocument;
    try {
      String? response = await storage.read(key: key);
      if (response == null) {
        return const Right(false);
      }
      final withoutBraces = response.substring(1, response.length - 1);
      final jsonString = withoutBraces;

      final List<dynamic> contents = jsonDecode(jsonString);
      final temporaryBets = contents
          .map((content) => TempBetEntityMapper.fromJson(content))
          .toList();
      temporaryBets.removeWhere((element) =>
          element.paymentId == paymentId && element.jackpotId == jackpotId);
      final handledBets =
          temporaryBets.map((element) => element.toString()).toList();
      final data = '{$handledBets}';
      await storage.write(key: key, value: data);
      return const Right(true);
    } catch (e, stack) {
      log('Erro: $e Stack: $stack');
      return Left(BadRequestJackException());
    }
  }
}
