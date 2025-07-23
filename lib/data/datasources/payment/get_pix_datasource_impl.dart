import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_datasource.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/payment_order_entity_mapper.dart';
import 'package:jackpot/domain/mappers/pix_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetPixDatasourceImpl implements IGetPixDatasource {
  @override
  Future<Either<IJackExceptions, PixEntity>> call(
      PaymentOrderEntity order) async {
    final dio = Dio();

    final body = PaymentOrderEntityMapper.toJson(order);
    try {
      final response =
          await dio.post('${JackEnvironment.paymentApi}payments/pix',
              data: json.encode(body),
              options: Options(
                headers: {
                  "Content-type": "application/json; charset=UTF-8",
                  'x-api-key': JackEnvironment.paymentApiKey
                },
              ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final pix = PixEntityMapper.fromJson(handledData);

      return Right(pix);
    } catch (e, data) {
      log('Erro ao realizar a pagamento PIX: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Falha ao tentar fazer pagamento Pix'));
    }
  }
}
