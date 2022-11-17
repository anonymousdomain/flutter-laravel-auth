import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lara_fl/helper/dio.dart';
import 'package:lara_fl/models/error.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../models/user.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  User? _user;
  ValidationError? _validationError;
  ValidationError? get validationError => _validationError;
  User? get user => _user;
  final storage = FlutterSecureStorage();
  bool get authenticated => _authenticated;
  bool _obscureText = false;

  bool get obscureText => _obscureText;

  Future register({credential}) async {
    String deviceId = await getDeviceId();
    try {
      di.Response res = await dio().post('user/register',
          data: json.encode(credential..addAll({'deviceId': deviceId})));
      String token = await res.data['token'];
      await attempt(token);
      await storeToken(token);
    } on di.DioError catch (e) {
      if (e.response?.statusCode == 422) {
        _validationError = ValidationError.fromJson(e.response!.data['errors']);
        notifyListeners();
      }
    }
  }

  Future login({required Map credential}) async {
    String deviceId = await getDeviceId();
    try {
      di.Response response = await dio().post('auth/token',
          data: json.encode(credential..addAll({'deviceId': deviceId})));
      String token = await response.data['token'];
      await attempt(token);
      await storeToken(token);
    } on di.DioError catch (e) {
      if (e.response?.statusCode == 422) {
        _validationError = ValidationError.fromJson(e.response!.data['errors']);
        notifyListeners();
      }
    }
  }

  Future attempt(String? token) async {
    try {
      di.Response res = await dio().get(
        'auth/user',
        options: di.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      _user = User.fromJson(res.data);

      _authenticated = true;
    } catch (e) {
      log('error log ${e.toString()}');
      _authenticated = false;
    }
    notifyListeners();
  }

  Future getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  Future storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    final token = await storage.read(key: 'auth');
    return token;
  }

  Future deleteToken() async {
    await storage.delete(key: 'auth');
  }

  Future logout() async {
    final token = await storage.read(key: 'auth');
    _authenticated = false;
    await dio().delete('auth/token/delete',
        data: {'deviceId': await getDeviceId()},
        options: di.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    await deleteToken();
    notifyListeners();
  }

  void toggleText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
