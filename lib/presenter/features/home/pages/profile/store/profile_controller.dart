import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool _isLoading = false;

  //////////////////////// GETS //////////////////////////////
  bool get loading => _isLoading;

  //////////////////////// FUNCTIONS //////////////////////////////

  setLoading({bool? value}) {
    if (value == null) {
      _isLoading = !_isLoading;
      notifyListeners();
      return;
    }
    _isLoading = value;
    notifyListeners();
  }
}
