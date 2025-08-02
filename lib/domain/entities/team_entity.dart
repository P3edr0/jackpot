import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';
import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class TeamEntity extends ResumeJackpotEntity {
  TeamEntity(
      {required super.jackpotId,
      required super.potValue,
      required super.title,
      required super.banner,
      required super.isFavorite,
      required this.logo,
      required this.name,
      required this.id,
      super.jackpotType = SportJackpotType.team});

  String name;
  String logo;
  String id;

  factory TeamEntity.empty(String id) {
    return TeamEntity(
      banner: '',
      id: id,
      isFavorite: false,
      jackpotId: '',
      name: '',
      potValue: '',
      logo: '',
      title: '',
    );
  }
}
