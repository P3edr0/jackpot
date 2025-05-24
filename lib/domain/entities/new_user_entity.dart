import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';

class NewUserEntity extends UserEntity {
  String? password;
  int? documentId;
  AddressEntity? address;
  String? image;
  NewUserEntity({
    super.id,
    required super.name,
    required super.email,
    required super.document,
    required super.birthDay,
    required super.phoneDDI,
    required super.phone,
    required super.countryId,
    required super.uzerId,
    required this.password,
    required this.documentId,
    required this.address,
    required this.image,
  });
}
