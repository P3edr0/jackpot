import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';

abstract class ICountryDatasource {
  Future<Either<IJackExceptions, List<CountryEntity>>> call();
}
