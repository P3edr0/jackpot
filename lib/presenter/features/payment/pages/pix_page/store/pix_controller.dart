import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/usecases/payment/get_pix_status_usecase.dart';
import 'package:jackpot/shared/utils/enums/payment_status.dart';

class PixController extends ChangeNotifier {
  PixController({required this.getPixStatusUsecase});
  GetPixStatusUsecase getPixStatusUsecase;
  bool _isLoading = false;
  bool _hasError = false;
  PixEntity? _pix;
  Timer? _pixTimer;
  Timer? _expirePixTimer;
  PaymentStatus _pixStatus = PaymentStatus.waiting;

  ///////////////// GET ///////////////////////
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  PixEntity? get pix => _pix;
  PaymentStatus? get pixStatus => _pixStatus;

  ///////////////// SET ///////////////////////
  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      _isLoading = newLoading;
      notifyListeners();
      return;
    }
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void setPix(PixEntity? newPix, [bool hasError = false]) {
    if (hasError) {
      _hasError = true;
      _pixStatus = PaymentStatus.error;
      notifyListeners();
      return;
    }
    _pix = newPix;
    if (_pixTimer == null) {
      startPixTimer();
    } else {
      _pixStatus = PaymentStatus.waiting;
    }
    notifyListeners();
  }

  Future<void> verifyPixStatus() async {
    final id = pix!.id;
    final response = await getPixStatusUsecase(id);
    response.fold(
      (l) {
        _pixStatus = PaymentStatus.error;
        notifyListeners();
      },
      (success) {
        _pixStatus = success;
        log('Verificando status do PIX - ${success.getLabel()}');
        notifyListeners();
      },
    );
  }

  startPixTimer() {
    cancelTimers();

    _expirePixTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      notifyListeners();
    });

    _pixTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      _pixStatus = PaymentStatus.waiting;
      await verifyPixStatus();
    });
  }

  void cancelTimers() {
    _pixTimer?.cancel();
    _expirePixTimer?.cancel();
  }
}
