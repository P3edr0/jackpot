import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class JackpotEntity {
  JackpotEntity(
      {required this.id,
      this.betId,
      required this.banner,
      this.potValue,
      required this.endAt,
      required this.budgetValue,
      this.awardsId,
      this.awards,
      required this.description,
      required this.jackpotType});
  String id;
  String? betId;
  String banner;
  String? potValue;
  DateTime endAt;
  String budgetValue;

  String description;
  List<String>? awardsId;
  List<AwardEntity>? awards;
  JackpotType jackpotType;
}
