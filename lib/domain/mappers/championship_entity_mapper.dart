import 'package:jackpot/domain/entities/championship_entity.dart';

class ChampionshipEntityMapper {
  static ChampionshipEntity fromJson(Map<String, dynamic> data) {
    final potValue = data['valorPote'].toString();
    return ChampionshipEntity(
      id: data['idCampeonato'].toString(),
      jackpotId: data['idJackPot'].toString(),
      name: data['nomeCampeonato'],
      teams: [],
      banner: data['bannerCampeonato'],
      potValue: potValue,
      title: data['title'] ?? data['nomeCampeonato'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
