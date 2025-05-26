import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

/// 401
class UnauthorisedException extends HttpException {
  UnauthorisedException({String? message, int? code = 401})
      : super(message, code);
}
