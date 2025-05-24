class AddressEntity {
  AddressEntity(
      {required this.cep,
      required this.street,
      required this.neighborhood,
      required this.city,
      required this.state,
      this.number,
      this.cityCode,
      this.ibgeCode,
      this.complement});
  String cep;
  String street;
  String neighborhood;
  String city;
  String state;
  String? number;
  String? complement;
  String? ibgeCode;
  int? cityCode;
}
