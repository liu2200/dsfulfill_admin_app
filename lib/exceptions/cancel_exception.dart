import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

class CancelException extends HttpException {
  CancelException([String? message]) : super(message);
}
