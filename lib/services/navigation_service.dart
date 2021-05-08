import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void pop() {
    navigatorKey.currentState.pop();
  }

  void popUntil(RoutePredicate routePredicate) {
    navigatorKey.currentState.popUntil(routePredicate);
  }

   pushWrapperAndRemoveAllRoutes(){
  return navigatorKey.currentState.pushNamedAndRemoveUntil( '/wrapper',(route) => false);
  }

   pushConfirmationAndRemoveAllRoutes(){
  return  navigatorKey.currentState.pushNamedAndRemoveUntil( '/confirmation_screen',(route) => false);
  }

}