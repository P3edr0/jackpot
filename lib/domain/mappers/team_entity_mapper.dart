import 'package:jackpot/domain/entities/team_entity.dart';

class TeamEntityMapper {
  static TeamEntity fromJson(Map<String, dynamic> data) {
    return TeamEntity(
      id: data['id'],
      name: data['name'],
      logo: data['logoURL'],
      banner: data['bannerURL'],
      potValue: data['potValue'] ?? '0',
      title: data['title'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
