import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_payment_public_key_datasource.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

class GetPaymentPublicKeyDatasourceImpl
    implements IGetPaymentPublicKeyDatasource {
  @override
  Future<Either<IJackExceptions, String>> call() async {
    final dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor());
    try {
      final response =
          await dio.get('${JackEnvironment.paymentApi}payments/public-key/card',
              options: Options(
                headers: {
                  "accept": "application/json",
                  "x-api-key": JackEnvironment.paymentApiKey
                },
              ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      final publicKey = handledData["chavePublica"];

      return Right(publicKey);
    } catch (e, data) {
      log('Erro ao realizar chave pública para cartão: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Falha ao tentar fazer pagamento via cartão'));
    }
  }
}
