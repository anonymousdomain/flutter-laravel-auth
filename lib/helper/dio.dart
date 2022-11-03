import 'package:dio/dio.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api/',
    headers: {'accept': 'application/json', 'content-type': 'application/json'},
    // responseType: ResponseType.plain,
    responseType: ResponseType.json,
  ));

  return dio;
}
