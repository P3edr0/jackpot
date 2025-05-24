import 'package:jackpot/domain/entities/resume_jackpot_entity.dart';

class ResumeJackpotEntityMapper {
  static ResumeJackpotEntity fromJson(Map<String, dynamic> data) {
    return ResumeJackpotEntity(
      jackpotId: data['id'].toString(),
      banner: data['bannerUrl'],
      potValue: data['potValue'].toString(),
      title: data['title'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}
