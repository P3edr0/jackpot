import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_status_datasource.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';
import 'package:jackpot/shared/utils/enums/payment_status.dart';

class GetPixStatusDatasourceImpl implements IGetPixStatusDatasource {
  @override
  Future<Either<IJackExceptions, PaymentStatus>> call(String id) async {
    final dio = Dio();

    try {
      final response =
          await dio.get('${JackEnvironment.paymentApi}payments/$id',
              options: Options(
                headers: {
                  "Content-type": "application/json; charset=UTF-8",
                  'x-api-key': JackEnvironment.paymentApiKey
                },
              ));

      final data = response.data;

      final handledData = Map<String, dynamic>.from(data);
      if (handledData["erro"]) {
        final message = handledData['descricaoErro'];
        log('Erro ao buscar PIX: $message');
        return const Right(PaymentStatus.error);
      }
      if (handledData["pago"]) {
        return const Right(PaymentStatus.success);
      }
      if (!handledData["pago"]) {
        return const Right(PaymentStatus.waiting);
      }
      log('Erro desconhecido ao buscar PIX');
      return Left(BadRequestJackException());
    } catch (e, data) {
      log('Erro ao buscar dados pagamento PIX: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Falha ao tentar buscar dados do Pix'));
    }
  }
}
