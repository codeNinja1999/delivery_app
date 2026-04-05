import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class AppNavigatorObserver extends NavigatorObserver {
  static final AppNavigatorObserver _instance = AppNavigatorObserver._internal();
  factory AppNavigatorObserver() => _instance; // Always returns the same instance

  AppNavigatorObserver._internal();

  final List<String> _routeHistory = [];
  List<String> get routeHistory => List.unmodifiable(_routeHistory); // Prevent external modification

  @override
  void didPop(Route route, Route? previousRoute) {
    LoadingView.hide();
    if (route.settings.name != null) {
      _routeHistory.remove(route.settings.name);
      _printNavigationPath();
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      _routeHistory.add(route.settings.name!);
      _printNavigationPath();
    }
    super.didPush(route, previousRoute);
  }

  void _printNavigationPath() {
    // ignore: avoid_print
    print("📍 Route History: ${_routeHistory.join(' → ')}");
  }

  String get currentRoute => _routeHistory.isNotEmpty ? _routeHistory.last : "Unknown";
}
