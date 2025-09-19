import 'package:jackpot/shared/utils/enums/bet_status.dart';

class TemporaryBetEntity {
  String? paymentId;
  int couponQuantity;
  String jackpotId;
  double couponPrice;
  double? paymentValue;
  String? pixCopyPaste;
  String? pixQrCode;
  BetStatus status;
  String? userDocument;
  DateTime? createdAt;
  TemporaryBetEntity(
      {this.paymentId,
      this.pixCopyPaste,
      this.pixQrCode,
      this.paymentValue,
      this.userDocument,
      this.createdAt,
      this.status = BetStatus.waitingPayment,
      required this.couponQuantity,
      required this.jackpotId,
      required this.couponPrice});

  @override
  String toString() {
    return '{"paymentId":"$paymentId","pixCopyPaste":"$pixCopyPaste","pixQrCode":"$pixQrCode", "createdAt":"$createdAt","status":"${status.name}","couponQuantity":"$couponQuantity","jackpotId":"$jackpotId", "couponPrice":"$couponPrice", "paymentValue":"$paymentValue"}';
  }
}
