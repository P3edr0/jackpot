import 'package:flutter/material.dart';
import 'package:jackpot/shared/utils/enums/coupons_base_quantity.dart';

class CouponSelectController extends ChangeNotifier {
  CouponSelectController();
  //////////////////////// VARS //////////////////////////////
  CouponsBaseQuantity? _couponsBaseQuantity = CouponsBaseQuantity.five;
  String? _oldReferenceJackpotId;
  int _couponsQuantity = 5;
  double _totalValue = 0;
  double _couponPrice = 0;
  bool _isLoading = true;

  //////////////////////// GETS //////////////////////////////
  CouponsBaseQuantity? get couponsBaseQuantity => _couponsBaseQuantity;
  int get couponsQuantity => _couponsQuantity;
  double get totalValue => _totalValue;
  double get couponPrice => _couponPrice;
  bool get isLoading => _isLoading;
  //////////////////////// FUNCTIONS //////////////////////////////
  void subtractCoupon() {
    if (_couponsQuantity <= 1) return;

    _couponsQuantity -= 1;
    if (_couponsQuantity > 0 && couponsBaseQuantity != null) {
      setCouponsBaseQuantity(null);
    }
    _updateTotalValue();
    notifyListeners();
  }

  void addCoupon() {
    _couponsQuantity += 1;
    if (_couponsQuantity > 0 && couponsBaseQuantity != null) {
      setCouponsBaseQuantity(null);
    }
    _updateTotalValue();
    notifyListeners();
  }

  _updateTotalValue([bool needUpdate = false]) {
    _totalValue = _couponsQuantity * _couponPrice;
    if (needUpdate) notifyListeners();
  }

  refreshPageDetails(String newJackpotId) {
    if (newJackpotId != _oldReferenceJackpotId) {
      _oldReferenceJackpotId = newJackpotId;
      _couponsBaseQuantity = CouponsBaseQuantity.five;
      _couponsQuantity = 5;
      notifyListeners();

      return;
    }
  }

  setLoading([bool? value]) {
    if (value == null) {
      _isLoading = !_isLoading;
      notifyListeners();
      return;
    }
    _isLoading = value;
    notifyListeners();
  }

  //////////////////////// SETS //////////////////////////////
  setCouponsBaseQuantity(CouponsBaseQuantity? newCouponBaseQuantity) {
    _couponsBaseQuantity = newCouponBaseQuantity;
    if (_couponsBaseQuantity != null) {
      _couponsQuantity = _couponsBaseQuantity!.value();
      _updateTotalValue();
    }
    notifyListeners();
  }

  void setCouponPrice(double newValue) {
    _couponPrice = newValue;

    _updateTotalValue();
    notifyListeners();
  }

  void setTotalValueComponents(double newCouponPrice, int newCouponsQuantity) {
    _couponPrice = newCouponPrice;
    _couponsQuantity = newCouponsQuantity;

    _updateTotalValue();
    notifyListeners();
  }
}
