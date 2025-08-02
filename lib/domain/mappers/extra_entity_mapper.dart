import 'package:jackpot/domain/entities/extra_jackpot_entity.dart';

class ExtraEntityMapper {
  static ExtraJackpotEntity fromJson(Map<String, dynamic> data) {
    final potValue = data['valorVendaCard'].toString();
    return ExtraJackpotEntity(
        id: data['id'].toString(),
        name: data['titulo'],
        type: data['tipo'],
        banner: data['fotoUrl'] ?? '',
        state: data['estado'],
        dozensPerCard: data['dezenasPorCartela'],
        dozensPerChoice: data['totalDezenasParaEscolha'],
        potValue: potValue,
        budgetValue: potValue,
        endAt: DateTime.now(),
        betId: data['idJackPot'].toString(),
        logo: data['logoTime'].toString(),
        description: data['descricao'] ?? '');
  }
}
