class RegisterEntity {
  RegisterEntity({required this.id, required this.secret});
  String id;
  String secret;

  String generate() {
    return '$id:$secret';
  }
}
