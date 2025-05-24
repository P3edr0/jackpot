class SessionEntity {
  SessionEntity(
      {required this.credential, required this.password, required this.image});
  final String credential;
  final String password;
  final String image;

  @override
  String toString() {
    return '{"credential":"$credential","password":"$password","image":"$image"}';
  }
}
