import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class CepService {
  Future<Either<IJackExceptions, AddressEntity>> call(String cep);
}
