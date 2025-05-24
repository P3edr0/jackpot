import 'package:jackpot/domain/entities/country_entity.dart';

class CountryMapper {
  static CountryEntity fromJson(Map<String, dynamic> data) {
    return CountryEntity(
      id: data['id'],
      name: data['nomePais'],
      image: data['imagem'],
      isoCode: data['codigoIso'],
      areaCode: data['codigoArea'],
    );
  }

  Map<String, dynamic> toJson(CountryEntity country) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = country.id;
    data['nomePais'] = country.name;
    data['imagem'] = country.image;
    data['codigoIso'] = country.isoCode;
    data['codigoArea'] = country.areaCode;
    return data;
  }
}
