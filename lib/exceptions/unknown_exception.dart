import 'package:dsfulfill_cient_app/exceptions/http_exception.dart';

class UnknownException extends HttpException {
  UnknownException([String? message]) : super(message);
}
