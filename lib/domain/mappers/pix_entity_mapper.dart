import 'package:jackpot/domain/entities/pix_entity.dart';

class PixEntityMapper {
  static PixEntity fromJson(Map<String, dynamic> data) {
    return PixEntity(
        id: data['id'].toString(),
        value: data['valor'] ?? 0.0,
        copyPaste: data['copiaECola'],
        qrCode: data['linkPng'] ?? data['"linkBase64"'],
        expireAt: DateTime.now().add(const Duration(minutes: 1439)));
  }
}
