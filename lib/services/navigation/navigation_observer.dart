import 'package:flutter/material.dart';

class NavigationObserver extends NavigatorObserver {
  final Set<RouteAware> _listeners = <RouteAware>{};

  void subscribe(RouteAware routeAware) {
    _listeners.add(routeAware);
  }

  void unsubscribe(RouteAware routeAware) {
    _listeners.remove(routeAware);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (var listener in _listeners) {
      listener.didPop();
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    for (var listener in _listeners) {
      listener.didPush();
    }
  }
}
