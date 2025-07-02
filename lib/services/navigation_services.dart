import 'package:chatify/models/chat.dart';
import 'package:flutter/material.dart';

class NavigationServices {
  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  void removeAndNavigateToRoute(String _route) {
    navigatorKey.currentState?.popAndPushNamed(_route);
  }

  void navigaterToRoute(String _route) {
    navigatorKey.currentState?.pushNamed(_route);
  }

  void navigaterToPage(Widget _page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext _context) {
          return _page;
        },
      ),
    );
  }

  void gobback() {
    navigatorKey.currentState?.pop();
  }
}
