import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void pop() {
    navigatorKey.currentState.pop();
  }

  void popUntil(RoutePredicate routePredicate) {
    navigatorKey.currentState.popUntil(routePredicate);
  }

  void pushWrapperAndRemoveAllRoutes(){
    navigatorKey.currentState.pushNamedAndRemoveUntil( '/wrapper',(route) => false);
  }
}