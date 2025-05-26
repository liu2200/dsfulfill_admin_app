import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

class BadResponseException extends HttpException {
  dynamic data;

  BadResponseException([this.data]) : super();
}
