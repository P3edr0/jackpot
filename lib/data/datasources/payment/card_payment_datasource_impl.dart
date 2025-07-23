import 'dart:convert';
import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/card_payment_datasource.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/mappers/payment_order_entity_mapper.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class CardPaymentDatasourceImpl implements ICardPaymentDatasource {
  @override
  Future<Either<IJackExceptions, String>> call(PaymentOrderEntity order) async {
    final dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    final body = PaymentOrderEntityMapper.toJson(order);
    try {
      final response =
          await dio.post('${JackEnvironment.paymentApi}payments/credit-card',
              data: json.encode(body),
              options: Options(
                headers: {
                  "Content-type": "application/json; charset=UTF-8",
                  'x-api-key': JackEnvironment.paymentApiKey
                },
              ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final paymentId = handledData['id'];

      return Right(paymentId);
    } catch (e, data) {
      log('Erro ao realizar a pagamento Cartão: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Falha ao tentar fazer pagamento Cartão'));
    }
  }
}
