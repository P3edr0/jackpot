import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/country_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/complements/login_repository.dart';

class CountryUsecase {
  CountryUsecase({required this.repository});
  ICountryRepository repository;
  Future<Either<IJackExceptions, List<CountryEntity>>> call() async {
    return repository();
  }
}
