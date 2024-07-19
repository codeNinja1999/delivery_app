import 'package:flutter/material.dart';

import '../../presentation/widgets/widgets.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    LoadingView.hide();
    super.didPop(route, previousRoute);
  }
}
