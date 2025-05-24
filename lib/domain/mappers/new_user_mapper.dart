import 'package:jackpot/domain/entities/new_user_entity.dart';
import 'package:jackpot/domain/mappers/address_mapper.dart';

class NewUserMapper {
  static NewUserEntity fromJson(Map<String, dynamic> data) {
    return NewUserEntity(
        id: data['id'],
        name: data['nome'],
        email: data['email'],
        document: data['cpf'],
        birthDay: data['dataNascimento'],
        phoneDDI: data['telefoneDDI'],
        phone: data['telefone'],
        countryId: data['idPais'],
        uzerId: data['uzerId'],
        image: data['imagem'],
        password: null,
        documentId: null,
        address: AddressMapper.fromJson(data['endereco']));
  }

  static Map<String, dynamic> toJson(NewUserEntity user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = user.name;
    data['email'] = user.email;
    data['cpf'] = user.document;
    data['dataNascimento'] = user.birthDay;
    data['telefoneDDI'] = user.phoneDDI;
    data['telefone'] = user.phone;
    data['uzerId'] = user.uzerId;
    data['idPais'] = user.countryId;
    data['idTipoDocumento'] = user.documentId;
    data['senha'] = user.password;
    data['endereco'] = AddressMapper.toJson(user.address!);
    data['imagem'] = user.image;
    return data;
  }
}
