import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

/// 服务端响应错误
class BadServiceException extends HttpException {
  BadServiceException({String? message, int? code}) : super(message, code);
}
