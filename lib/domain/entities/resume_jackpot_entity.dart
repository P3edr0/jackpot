import 'package:jackpot/shared/utils/enums/jackpot_type.dart';

class ResumeJackpotEntity {
  ResumeJackpotEntity(
      {required this.jackpotId,
      required this.banner,
      required this.potValue,
      required this.title,
      required this.isFavorite,
      this.jackpotType});
  String banner;
  String jackpotId;
  String potValue;
  String title;
  bool isFavorite;
  JackpotType? jackpotType;
}
