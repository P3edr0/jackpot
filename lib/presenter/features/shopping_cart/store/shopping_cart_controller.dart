import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/award_entity.dart';
import 'package:jackpot/domain/entities/shopping_cart_jackpot_entity.dart';
import 'package:jackpot/domain/entities/sport_jackpot_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/usecases/jackpot/get_jackpot_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartController extends ChangeNotifier {
  ShoppingCartController({required this.getJackpotUsecase});
  ////////////////// VARS /////////////////////////
  final GetJackpotUsecase getJackpotUsecase;
  bool _loading = false;

  int totalCoupons = 0;
  double totalPrice = 0;
  List<JackpotAggregateEntity> _cartItems = [];
  ////////////////// GETS /////////////////////////
  List<JackpotAggregateEntity> get cartItems => _cartItems;
  bool get loading => _loading;
  ////////////////// FUNCTIONS /////////////////////////
  addShoppingCartItem(SportJackpotEntity jackpot, int couponsQuantity,
      double couponsPrice, String? uzerId) {
    final newJackpot = JackpotAggregateEntity(
        jackpot: jackpot,
        couponPrice: couponsPrice,
        couponsQuantity: couponsQuantity);
    bool added = false;
    for (var item in cartItems) {
      if (item.jackpot.id == jackpot.id) {
        item.couponsQuantity = item.couponsQuantity + couponsQuantity;
        added = true;
      }
    }
    if (!added) cartItems.add(newJackpot);
    saveLocalCart(uzerId);
    sumCoupons();
  }

  void updateItemsAwards(List<AwardEntity> awards) {
    for (var item in _cartItems) {
      final jackpotAwards = awards
          .where((award) => item.jackpot.awardsId!.contains(award.id))
          .toList();
      item.jackpot.awards = jackpotAwards;
    }
    notifyListeners();
  }

  saveLocalCart(
    String? id,
  ) async {
    final handledJackpots = _cartItems
        .map((item) => {
              'id': item.jackpot.id,
              'couponsQuantity': item.couponsQuantity,
              'couponPrice': item.couponPrice
            })
        .toList();
    final preferences = await SharedPreferences.getInstance();
    final bool success = await preferences.setString(
        'jackpots', json.encode({'uzerId': id, 'jackpots': handledJackpots}));
    if (success) {
      log('Sucesso');
      return;
    }
    log('Falha ao salvar local');
  }

  getLocalCart(
    String? id,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final response = preferences.get('jackpots');
    final handledJackpots =
        json.decode(response as String) as Map<String, dynamic>;
    final jackpots =
        List<Map<String, dynamic>>.from(handledJackpots['jackpots']);
    log(jackpots.toString());
    List<Future> callbacks = [];

    for (var jack in jackpots) {
      final String jackId = jack['id'];
      callbacks.add(getJackpotUsecase(jackId));
    }
    final List<JackpotAggregateEntity> tempList = [];

    final responses = await Future.wait(callbacks);
    for (var response in responses) {
      final handledResponse =
          response as Either<IJackExceptions, SportJackpotEntity>;
      handledResponse.fold((exception) {}, (jackpot) {
        final jackMap = jackpots.firstWhere((map) => map['id'] == jackpot.id);
        final newItem = JackpotAggregateEntity(
            jackpot: jackpot,
            couponsQuantity: jackMap['couponsQuantity'],
            couponPrice: jackMap['couponPrice'] ?? jackMap['couponsPrice']);
        tempList.add(newItem);
      });
    }
    final items = tempList
        .where((item) => DateTime.now().isBefore(item.jackpot.endAt))
        .toList();
    _cartItems = [...items];
    sumCoupons();
    notifyListeners();
  }

  sumCoupons() {
    totalCoupons = 0;
    totalPrice = 0;

    for (var element in _cartItems) {
      totalCoupons = totalCoupons + element.couponsQuantity;
      final jackPrices = element.couponPrice * element.couponsQuantity;
      totalPrice = totalPrice + jackPrices;
    }
    notifyListeners();
  }

  removeItem(JackpotAggregateEntity jack) {
    final tempItems = [...cartItems]..remove(jack);
    _cartItems = tempItems;
    saveLocalCart(null);
    sumCoupons();
    notifyListeners();
  }

  setLoading([bool? newLoading]) {
    if (newLoading != null) {
      _loading = newLoading;
      notifyListeners();
      return;
    }
    _loading = !_loading;
    notifyListeners();
  }
}
