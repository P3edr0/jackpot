import 'package:jackpot/domain/entities/resume_team_entity.dart';

class ResumeTeamEntityMapper {
  static ResumeTeamEntity fromJson(Map<String, dynamic> data) {
    return ResumeTeamEntity(
      id: data['id'].toString(),
      name: data['name'],
      logo: data['logoURL'],
      banner: data['bannerURL'],
    );
  }
}
