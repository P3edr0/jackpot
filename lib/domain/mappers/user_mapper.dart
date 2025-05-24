import 'package:jackpot/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity fromJson(Map<String, dynamic> data) {
    final dataUser = data['usuario'] ?? {"": ""};
    final haveProfile = data['existente'];

    return UserEntity(
      haveProfile: haveProfile,
      name: dataUser['nome'],
      email: dataUser['email'],
      document: dataUser['cpf'],
      birthDay: dataUser['dataNascimento'],
      phoneDDI: dataUser['telefoneDDI'],
      phone: dataUser['telefone'],
      verified: dataUser['verificado'],
      statusSynch: dataUser['statusSincronia'],
      countryId: dataUser['idPais'],
      id: dataUser['id'],
      uzerId: dataUser['uzerId'],
      minor: dataUser['menor'] ?? false,
    );
  }

  Map<String, dynamic> toJson(UserEntity user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = user.name;
    data['email'] = user.email;
    data['cpf'] = user.document;
    data['dataNascimento'] = user.birthDay;
    data['telefoneDDI'] = user.phoneDDI;
    data['telefone'] = user.phone;
    data['verificado'] = user.verified;
    data['statusSincronia'] = user.statusSynch;
    return data;
  }
}
