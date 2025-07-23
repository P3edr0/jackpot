import 'dart:developer';

import 'package:flutter/material.dart';

class RouteStackObserver extends NavigatorObserver {
  RouteStackObserver._();
  factory RouteStackObserver.instance() {
    _instance ??= RouteStackObserver._();

    return _instance!;
  }

  static RouteStackObserver? _instance;
  final List<Route<dynamic>> _routeStack = [];

  List<Route<dynamic>> get currentStack => List.unmodifiable(_routeStack);
  List<String?> get currentStackNames =>
      _routeStack.map((element) => element.settings.name).toList();

  @override
  void didPush(Route route, Route? previousRoute) {
    _routeStack.add(route);
    for (var route in _routeStack) {
      debugPrint(route.settings.name);
    }
    log('Pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _routeStack.remove(route);
    log('Popped: ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _routeStack.remove(route);
    log('Removed: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) _routeStack.remove(oldRoute);
    if (newRoute != null) _routeStack.add(newRoute);
    log('Replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }
}
