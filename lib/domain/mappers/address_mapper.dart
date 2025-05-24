import 'package:jackpot/domain/entities/address_entity.dart';

class AddressMapper {
  static AddressEntity fromJson(Map<String, dynamic> data) {
    return AddressEntity(
      cep: data['cep'] ?? '',
      state: data['estado'] ?? '',
      city: data['localidade'] ?? '',
      neighborhood: data['bairro'] ?? '',
      street: data['logradouro'] ?? '',
      cityCode: null,
      ibgeCode: data['ibge'] ?? '',
      number: data['numero'],
    );
  }

  static Map<String, dynamic> toJson(AddressEntity address) {
    return {
      "cep": address.cep,
      "logradouro": address.street,
      "complemento": address.complement,
      "bairro": address.neighborhood,
      "numero": address.number,
      "cidade": {"id": address.cityCode, "nome": address.city}
    };

    // {
//                     "cep": cadastroUsuario!.endereco!.cep, //"74594001"
//                     "logradouro": cadastroUsuario!.endereco!.logradouro,
//                     "complemento": cadastroUsuario!.endereco!.complemento,
//                     "bairro": cadastroUsuario!.endereco!.bairro,
//                     "numero": cadastroUsuario!.endereco!.numero,
//                     "cidade": {
//                       "id": cadastroUsuario!.endereco!.cidade!.id,
//                       "nome": cadastroUsuario!.endereco!.cidade!.nome
//                     }
//                   },
  }
}
