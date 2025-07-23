import 'package:jackpot/domain/entities/jackpot_entity.dart';

class JackpotAggregateEntity {
  JackpotAggregateEntity({
    required this.jackpot,
    required this.couponsQuantity,
    required this.couponPrice,
  });
  JackpotEntity jackpot;
  int couponsQuantity;
  double couponPrice;
}
