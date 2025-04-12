import 'package:jackpot/domain/entities/jackpot_entity.dart';

class TeamEntity extends JackpotEntity {
  TeamEntity({
    required super.id,
    required super.potValue,
    required super.title,
    required super.banner,
    required super.isFavorite,
    required this.logo,
    required this.name,
  });

  String name;
  String logo;
}
