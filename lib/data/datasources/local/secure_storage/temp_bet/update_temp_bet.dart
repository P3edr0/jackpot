import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jackpot/data/datasources/base_datasources/jackpot/bet/create_temp_bet_datasource.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/temp_bet_entity_mapper.dart';

class SecureStorageUpdateTempBet implements IUpdateTempBetDatasource {
  @override
  Future<Either<IJackExceptions, bool>> call(
      List<TemporaryBetEntity> tempBets) async {
    const storage = FlutterSecureStorage();
    final key = tempBets.first.userDocument!;
    try {
      final oldContent = await storage.read(key: key);

      if (oldContent == null) {
        final handledBets =
            tempBets.map((element) => element.toString()).toList();
        final data = '{$handledBets}';
        await storage.write(key: key, value: data);
        return const Right(true);
      } else {
        // if (oldContent.startsWith('{[') && oldContent.endsWith(']}')) {
        final withoutBraces = oldContent.substring(1, oldContent.length - 1);
        final jsonString = withoutBraces;

        final List<dynamic> contents = jsonDecode(jsonString);
        final temporaryBets = contents
            .map((content) => TempBetEntityMapper.fromJson(content))
            .toList();
        for (var newTempBet in tempBets) {
          for (var oldTempBet in temporaryBets) {
            if (newTempBet.paymentId == oldTempBet.paymentId) {
              oldTempBet.status = newTempBet.status;
              newTempBet.paymentId = null;
            }
          }
        }
        final handledNewBet =
            tempBets.where((item) => item.paymentId != null).toList();
        final newTemporaryBetList = [...temporaryBets, ...handledNewBet];
        final handledBets =
            newTemporaryBetList.map((element) => element.toString()).toList();
        final data = '{$handledBets}';
        await storage.write(key: key, value: data);
        return const Right(true);
        // }
      }
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException());
    }
  }
}
