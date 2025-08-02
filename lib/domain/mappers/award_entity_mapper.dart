import 'package:jackpot/domain/entities/award_entity.dart';

class AwardEntityMapper {
  static AwardEntity fromJson(Map<String, dynamic> data) {
    return AwardEntity(
      id: data['id'].toString(),
      image: data['bannerURL'].toString(),
      name: data['description'],
      isActive: data['active'],
    );
  }
}
