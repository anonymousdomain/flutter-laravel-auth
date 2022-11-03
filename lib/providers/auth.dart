import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  bool get authenticated => _authenticated;
  void login({required Map credential}) {
    _authenticated = true;
    notifyListeners();
  }
}
