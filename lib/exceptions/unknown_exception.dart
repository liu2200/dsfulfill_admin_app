import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

class UnknownException extends HttpException {
  UnknownException([String? message]) : super(message);
}
