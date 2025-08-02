import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/card_payment_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_payment_public_key_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_datasource.dart';
import 'package:jackpot/data/datasources/base_datasources/payment/get_pix_status_datasource.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';
import 'package:jackpot/shared/utils/enums/payment_status.dart';

class GetPixRepositoryImpl implements IGetPixRepository {
  GetPixRepositoryImpl({required this.datasource});
  IGetPixDatasource datasource;

  @override
  Future<Either<IJackExceptions, PixEntity>> call(
      PaymentOrderEntity order) async {
    final response = await datasource(order);
    return response;
  }
}

class CardPaymentRepositoryImpl implements ICardPaymentRepository {
  CardPaymentRepositoryImpl({required this.datasource});
  ICardPaymentDatasource datasource;

  @override
  Future<Either<IJackExceptions, String>> call(PaymentOrderEntity order) async {
    final response = await datasource(order);
    return response;
  }
}

class GetPixStatusRepositoryImpl implements IGetPixStatusRepository {
  GetPixStatusRepositoryImpl({required this.datasource});
  IGetPixStatusDatasource datasource;

  @override
  Future<Either<IJackExceptions, PaymentStatus>> call(String id) async {
    final response = await datasource(id);
    return response;
  }
}

class GetPaymentPublicKeyRepositoryImpl
    implements IGetPaymentPublicKeyRepository {
  GetPaymentPublicKeyRepositoryImpl({required this.datasource});
  IGetPaymentPublicKeyDatasource datasource;

  @override
  Future<Either<IJackExceptions, String>> call() async {
    final response = await datasource();
    return response;
  }
}
