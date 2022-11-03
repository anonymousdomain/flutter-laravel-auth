import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as di;
import 'package:flutter/material.dart';
import 'package:lara_fl/helper/dio.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;

  bool get authenticated => _authenticated;

  Future login({required Map credential}) async {
    di.Response response =
        await dio().post('auth/token', data: json.encode(credential));
    String $token = json.decode(json.encode(response.data));
    _authenticated = true;
    log($token);
    notifyListeners();
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
