import 'package:jackpot/domain/entities/championship_entity.dart';

class ChampionshipEntityMapper {
  static ChampionshipEntity fromJson(Map<String, dynamic> data) {
    return ChampionshipEntity(
      id: data['id'],
      name: data['name'],
      teams: [],
      banner: data['bannerURL'],
      potValue: data['potValue'] ?? '0',
      title: data['title'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
