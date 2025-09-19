import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/shared/utils/enums/tab_navigation_options.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';

class RouteStackObserver extends NavigatorObserver with ChangeNotifier {
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
  String? get currentRoute =>
      _routeStack.map((element) => element.settings.name).toList().last;

  @override
  void didPush(Route route, Route? previousRoute) {
    _routeStack.add(route);
    for (var route in _routeStack) {
      debugPrint(route.settings.name);
    }
    log('Pushed: ${route.settings.name}');
    if (route.settings.name == AppRoutes.home) {
      setSelectedNavBar(JackTabNavigationOptions.home);
    }
    if (route.settings.name == AppRoutes.myJackpots) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
    if (route.settings.name == AppRoutes.myJackpotsDetails) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _routeStack.remove(route);
    log('Popped: ${route.settings.name}');

    if (previousRoute?.settings.name == AppRoutes.home) {
      setSelectedNavBar(JackTabNavigationOptions.home);
    }
    if (previousRoute?.settings.name == AppRoutes.myJackpots) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
    if (previousRoute?.settings.name == AppRoutes.myJackpotsDetails) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
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

  JackTabNavigationOptions selectedNavBar = JackTabNavigationOptions.home;

  setSelectedNavBar(JackTabNavigationOptions newNavBar) {
    selectedNavBar = newNavBar;
    notifyListeners();
  }

  setSelectedNavBarByName(String newNavBar) {
    if (newNavBar == AppRoutes.home) {
      setSelectedNavBar(JackTabNavigationOptions.home);
    }
    if (newNavBar == AppRoutes.myJackpots) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
    if (newNavBar == AppRoutes.myJackpotsDetails) {
      setSelectedNavBar(JackTabNavigationOptions.jacks);
    }
  }
}
