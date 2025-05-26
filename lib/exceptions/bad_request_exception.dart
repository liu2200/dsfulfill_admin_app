import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

/// 客户端请求错误
class BadRequestException extends HttpException {
  BadRequestException({String? message, int? code}) : super(message, code);
}
