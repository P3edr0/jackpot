import 'package:jackpot/services/entities/token_entity.dart';

class TokenMapper {
  static TokenEntity fromJson(Map<String, dynamic> data) {
    return TokenEntity(
        aux: data['token_type'],
        token: data['access_token'],
        isAdmin: data['ehAdmin'] ?? false);
  }
}
