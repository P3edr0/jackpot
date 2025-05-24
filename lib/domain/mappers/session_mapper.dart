import 'package:jackpot/domain/entities/session_entity.dart';

class SessionMapper {
  static Map<String, dynamic> toJson(SessionEntity data) {
    return {
      'credential': data.credential,
      'passWord': data.password,
      'image': data.image,
    };
  }

  static SessionEntity fromJson(Map<String, dynamic> data) {
    return SessionEntity(
      credential: data['credential'],
      password: data['password'],
      image: data['image'],
    );
  }
}
