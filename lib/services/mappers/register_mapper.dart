import 'package:jackpot/services/entities/register_entity.dart';

class RegisterMapper {
  static RegisterEntity fromJson(Map<String, dynamic> data) {
    return RegisterEntity(
      id: data['id'],
      secret: data['segredo'],
    );
  }
}
