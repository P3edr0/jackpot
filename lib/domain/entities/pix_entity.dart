class PixEntity {
  String id;
  double value;
  String qrCode;
  String copyPaste;
  DateTime expireAt;

  PixEntity(
      {required this.id,
      required this.value,
      required this.qrCode,
      required this.expireAt,
      required this.copyPaste});
}
