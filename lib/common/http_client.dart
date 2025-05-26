import 'package:dio/dio.dart';
import 'package:dsfulfill_admin_app/exceptions/network_exception.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dsfulfill_admin_app/common/http_response.dart';
import 'package:dsfulfill_admin_app/transformer/http_transformer.dart';
import 'package:dsfulfill_admin_app/common/app_dio.dart';
import 'package:dsfulfill_admin_app/transformer/http_parse.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_admin_app/utils/base_utils.dart';

enum Methods { get, post, put, delete }

extension MethodStr on Methods {
  String get name {
    switch (this) {
      case Methods.get:
        return 'GET';
      case Methods.post:
        return 'POST';
      case Methods.put:
        return 'PUT';
      case Methods.delete:
        return 'DELETE';
    }
  }
}

class ApiConfig {
  late final BaseDio _dio;
  static late final ApiConfig instance = ApiConfig._internal();

  ApiConfig._internal() {
    _dio = BaseDio();
  }
  Future<HttpResponse> _request(
    String uri, {
    Methods? method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? httpTransformer,
  }) async {
    options ??= Options();
    options.method = (method ?? Methods.get).name;
    try {
      if (Get.isRegistered<AppState>() &&
          Get.find<AppState>().networkDisconnect.value) {
        // 网络无连接
        BaseUtils.showToast('网络连接失败，请检查网络设置');
        return HttpResponse.failureFromError(
            NetworkException(message: '网络连接失败，请检查网络设置'));
      }

      // 处理查询参数中的数组
      Map<String, dynamic> processedQueryParams = {};
      if (queryParameters != null) {
        queryParameters.forEach((key, value) {
          if (value is List) {
            // 将数组转换为逗号分隔的字符串
            processedQueryParams[key] = value.join(',');
          } else {
            processedQueryParams[key] = value;
          }
        });
      }

      var response = await _dio.request(
        uri,
        options: options,
        data: data,
        queryParameters: {
          ...processedQueryParams,
        },
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      var res = handleResponse(response, httpTransformer: httpTransformer);
      if (res.ok &&
          options.method != Methods.get.name &&
          Methods.get.name != 'GET' &&
          !uri.contains('refresh-token') &&
          options.extra?['showSuccess'] != false) {
        EasyLoading.showSuccess(res.msg ?? '');
      }
      if (!res.ok && options.extra?['showError'] != false) {
        EasyLoading.showError(res.error?.message ?? '');
      }
      return res;
    } on Exception catch (e) {
      handleException(e);
      rethrow;
    }
  }

  Future<HttpResponse> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      data,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    return await _request(
      uri,
      queryParameters: queryParameters,
      options: options,
      data: data,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      httpTransformer: httpTransformer,
    );
  }

  Future<HttpResponse> post(String uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    return await _request(
      uri,
      method: Methods.post,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      httpTransformer: httpTransformer,
    );
  }

  Future<HttpResponse> delete(String uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    return await _request(
      uri,
      method: Methods.delete,
      data: data,
      options: options,
      cancelToken: cancelToken,
      httpTransformer: httpTransformer,
    );
  }

  Future<HttpResponse> put(String uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    return await _request(
      uri,
      method: Methods.put,
      data: data,
      options: options,
      cancelToken: cancelToken,
      httpTransformer: httpTransformer,
    );
  }

  // Future<Uint8List?> getImage(String uri) async {
  //   try {
  //     Response<List<int>> response = await _baseDio.get<List<int>>(
  //       uri,
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           headers: {'Connection': 'keep-alive'}),
  //     );
  //     if (response.statusCode == 200) {
  //       return Uint8List.fromList(response.data!);
  //     }
  //     return null;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Response> download(String urlPath, savePath,
  //     {ProgressCallback? onReceiveProgress,
  //     Map<String, dynamic>? queryParameters,
  //     CancelToken? cancelToken,
  //     bool deleteOnError = true,
  //     String lengthHeader = Headers.contentLengthHeader,
  //     data,
  //     Options? options,
  //     HttpTransformer? httpTransformer}) async {
  //   try {
  //     var response = await _dio.download(
  //       urlPath,
  //       savePath,
  //       onReceiveProgress: onReceiveProgress,
  //       queryParameters: queryParameters,
  //       cancelToken: cancelToken,
  //       deleteOnError: deleteOnError,
  //       lengthHeader: lengthHeader,
  //       data: data,
  //       options: data,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
