import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:dsfulfill_admin_app/common/http_client.dart';
import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BaseInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if ((options.extra['loading'] != false &&
            !options.uri.path.contains('refresh-token') &&
            options.method != Methods.get.name) ||
        options.extra['loading'] == true) {
      EasyLoading.show();
    }
    var accessToken = CommonStorage.getToken();
    if (accessToken.isNotEmpty) {
      options.headers["authorization"] = accessToken;
    }
    options.headers['Language'] =
        CommonStorage.getLanguage() ?? const Locale('en_US');
    options.headers["x-requested-with"] = 'XMLHttpRequest';
    options.headers["source"] = Platform.isAndroid ? "android" : "ios";

    return handler.next(options);
  }
}
