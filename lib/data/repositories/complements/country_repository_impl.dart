import 'package:dartz/dartz.dart';
import 'package:jackpot/data/datasources/base_datasources/complements/country_datasource.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/complements/login_repository.dart';

class CountryRepositoryImpl implements ICountryRepository {
  CountryRepositoryImpl({required this.datasource});

  ICountryDatasource datasource;
  @override
  Future<Either<IJackExceptions, List<CountryEntity>>> call() async {
    final response = await datasource();
    return response;
  }
}
