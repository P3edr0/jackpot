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
      // final pix = PixEntity(
      //     id: "720078ce-d74d-4950-a5a3-38e92c4cd22c",
      //     value: 1.99,
      //     qrCode:
      //         "https://api.pagseguro.com/qrcode/QRCO_8240628B-D4A5-4ED6-9C41-AA6D6E6372BB/png",
      //     expireAt: DateTime.now().add(const Duration(minutes: 1439)),
      //     copyPaste:
      //         "00020101021226830014br.gov.bcb.pix2561api.pagseguro.com/pix/v2/8240628B-D4A5-4ED6-9C41-AA6D6E6372BB27600016BR.COM.PAGSEGURO01368240628B-D4A5-4ED6-9C41-AA6D6E6372BB52047311530398654046.995802BR5922UZER SOLUCOES E TECNOL6007Goiania62070503***63049E01");
      // final pix2 = PixEntity(
      //     id: "3722d8b5-90bc-4b2c-8cbf-716db62679d2",
      //     value: 5.00,
      //     qrCode:
      //         "https://api.pagseguro.com/qrcode/QRCO_8240628B-D4A5-4ED6-9C41-AA6D6E6372BB/png",
      //     expireAt: DateTime.now().add(const Duration(minutes: 1439)),
      //     copyPaste:
      //         "00020101021226830014br.gov.bcb.pix2561api.pagseguro.com/pix/v2/8240628B-D4A5-4ED6-9C41-AA6D6E6372BB27600016BR.COM.PAGSEGURO01368240628B-D4A5-4ED6-9C41-AA6D6E6372BB52047311530398654046.995802BR5922UZER SOLUCOES E TECNOL6007Goiania62070503***63049E01");
      return Right(pix);
    } catch (e, data) {
      log('Erro ao realizar a pagamento PIX: $e \n $data');
      return Left(BadRequestJackException(
          message: 'Falha ao tentar fazer pagamento Pix'));
    }
  }
}
