import 'package:jackpot/domain/entities/preview_jackpot_entity.dart';

class PreviewJackpotEntityMapper {
  static PreviewJackpotEntity fromJson(Map<String, dynamic> data) {
    return PreviewJackpotEntity(
      jackpotId: data['idJackpot'].toString(),
      banner: data['jackpotBanner'],
      potValue: data['valorPote'].toString(),
      teamName: data['nomeTime'],
      championshipName: data['nomeCampeonato'],
      championshipId: data['idCampeonato'].toString(),
      teamId: data['idTime'].toString(),
    );
  }
}
