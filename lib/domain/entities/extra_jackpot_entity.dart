import 'package:jackpot/domain/entities/jackpot_entity.dart';
import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class ExtraJackpotEntity extends JackpotEntity {
  ExtraJackpotEntity(
      {required super.id,
      super.betId,
      super.awards,
      super.awardsId,
      required super.banner,
      required super.budgetValue,
      required super.description,
      required super.endAt,
      super.potValue,
      required this.logo,
      required this.name,
      required this.type,
      required this.state,
      required this.dozensPerChoice,
      required this.dozensPerCard,
      super.jackpotType = JackpotType.extra});

  String name;
  String type;
  String state;
  String logo;
  int dozensPerChoice;
  int dozensPerCard;
}
