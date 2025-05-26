import 'package:dio/dio.dart';
import 'package:dsfulfill_admin_app/common/http_response.dart';

/// Response 解析
abstract class HttpTransformer {
  HttpResponse parse(Response response);
}
