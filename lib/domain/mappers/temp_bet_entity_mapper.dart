import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class TempBetEntityMapper {
  static TemporaryBetEntity fromJson(Map<String, dynamic> data) {
    return TemporaryBetEntity(
      couponPrice: double.parse(data['couponPrice']),
      couponQuantity: int.parse(data['couponQuantity']),
      jackpotId: data['jackpotId'],
      createdAt: DateTime.parse(data['createdAt']),
      paymentId: data['paymentId'],
      pixCopyPaste: data['pixCopyPaste'],
      pixQrCode: data['pixQrCode'],
      status: BetStatus.translate(data['status']),
      userDocument: data['userDocument'],
      paymentValue: double.tryParse(data['paymentValue']),
    );
  }
}
