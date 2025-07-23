import 'package:jackpot/domain/entities/payment_card_entity.dart';

class PaymentOrderEntity {
  PaymentOrderEntity(
      {required this.name,
      required this.document,
      required this.description,
      required this.email,
      required this.phone,
      required this.itemQuantity,
      required this.itemUnitValue,
      this.cardData});
  String document;
  String name;
  String email;
  String phone;
  String description;
  int itemQuantity;
  double itemUnitValue;
  PaymentCard? cardData;
}
