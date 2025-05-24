import 'dart:developer';

class TokenEntity {
  TokenEntity({required this.aux, required this.token, this.isAdmin = false});
  String aux;
  String token;
  bool isAdmin;

  String generate() {
    log('$aux $token');
    return '$aux $token';
  }

  @override
  String toString() {
    return ' Token: $aux => $token';
  }
}
