import 'package:jackpot/domain/entities/team_entity.dart';

class TeamEntityMapper {
  static TeamEntity fromJson(Map<String, dynamic> data) {
    final potValue = data['valorPote'].toString();
    return TeamEntity(
      id: data['idTime'].toString(),
      jackpotId: data['idJackPot'].toString(),
      name: data['nomeTime'],
      logo: data['logoTime'],
      banner: data['bannerTime'],
      potValue: potValue,
      title: data['title'] ?? data['nomeTime'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
