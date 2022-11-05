import 'package:dio/dio.dart';
import 'package:lara_fl/providers/auth.dart';

Dio dio() {
  var dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/',
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      },
      responseType: ResponseType.json,
    ),
  );

  // ignore: avoid_single_cascade_in_expression_statements
  dio
    ..interceptors.add(InterceptorsWrapper(
        onRequest: ((options, handler) => requestInterceptor(options))));

  return dio;
}

dynamic requestInterceptor(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    var token = await Auth().getToken();

    options.headers.addAll({
      'Authorization': 'Bearer $token',
    });
  }
}
