import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
        baseUrl: Globals.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        //15 SECONDS
        sendTimeout: const Duration(seconds: 3),
        contentType: 'application/json',
        responseType: ResponseType.json));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class Globals {
  static String baseUrl = "https://www.shinestreamlive.com/Api_controller";
  // static String baseUrl = "http://developer.shinestreamlive.com/Api_controller";
  static String imageBaseUrl = "https://shinestreamlive.com/";
  // static String imageBaseUrl = "http://developer.shinestreamlive.com/";
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log("Requested BASE URL===>>>::::::::::${options.baseUrl}${options.path}::::::::::::::::");
    log("Request Header::::::::::${options.headers.entries}::::::::::::::::");
    log("Request Payload::::::::::${options.data}::::::::::::::::");

    return handler.next(options);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    log('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');

    return super.onError(error, handler);
  }

  Future<Response> retryRequest(RequestOptions requestOptions, Dio dio, ErrorInterceptorHandler handler) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    log("Retry++++$requestOptions:$dio");
    return dio.request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }
}
