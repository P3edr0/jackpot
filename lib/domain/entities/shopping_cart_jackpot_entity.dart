import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';

class JackpotAggregateEntity {
  JackpotAggregateEntity({
    required this.jackpot,
    required this.couponsQuantity,
    required this.couponPrice,
  });
  SportJackpotEntity jackpot;
  int couponsQuantity;
  double couponPrice;
}
