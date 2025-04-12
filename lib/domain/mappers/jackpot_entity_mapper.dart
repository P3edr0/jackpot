import 'package:jackpot/domain/entities/jackpot_entity.dart';

class JackpotEntityMapper {
  static JackpotEntity fromJson(Map<String, dynamic> data) {
    return JackpotEntity(
      id: data['id'],
      banner: data['bannerUrl'],
      potValue: data['potValue'],
      title: data['title'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
