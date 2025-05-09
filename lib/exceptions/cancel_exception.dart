import 'package:dsfulfill_cient_app/exceptions/http_exception.dart';

class CancelException extends HttpException {
  CancelException([String? message]) : super(message);
}
