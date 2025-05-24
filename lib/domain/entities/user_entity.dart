class UserEntity {
  bool? haveProfile;
  int? id;
  String? name;
  String? email;
  String? document;
  String? birthDay;
  int? phoneDDI;
  String? phone;
  int? countryId;
  bool? verified;
  int? statusSynch;
  int? uzerId;
  bool? minor;

  UserEntity(
      {this.haveProfile,
      this.name,
      this.email,
      this.document,
      this.birthDay,
      this.phoneDDI,
      this.phone,
      this.verified,
      this.statusSynch,
      this.countryId,
      this.id,
      this.uzerId,
      this.minor});
}
