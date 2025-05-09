import 'package:dio/dio.dart';
import 'package:dsfulfill_cient_app/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:dsfulfill_cient_app/config/http_config.dart';
import 'package:dsfulfill_cient_app/interceptors/auth_interceptor.dart';
import 'package:dsfulfill_cient_app/interceptors/response_interceptor.dart';

class BaseDio extends DioMixin implements Dio {
  BaseDio({BaseOptions? options, WebConfiguration? dioConfig}) {
    options ??= BaseOptions(
      contentType: 'application/json',
      connectTimeout: Duration(seconds: dioConfig?.connectTimeout ?? 0),
      sendTimeout: Duration(seconds: dioConfig?.sendTimeout ?? 0),
      receiveTimeout: Duration(seconds: dioConfig?.receiveTimeout ?? 0),
    )..headers = dioConfig?.headers;
    options.baseUrl = BaseUrls.getBaseApi(); //基础API
    this.options = options;
//权限验证中间件，加入TOKEN
    interceptors.add(BaseInterceptor());
    if (kDebugMode) {
      interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    interceptors.add(ResponseInterceptor());
    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(dioConfig!.interceptors!);
    }

    httpClientAdapter = HttpClientAdapter();
  }
}
