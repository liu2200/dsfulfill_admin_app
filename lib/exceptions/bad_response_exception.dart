import 'package:dsfulfill_cient_app/exceptions/http_exception.dart';

class BadResponseException extends HttpException {
  dynamic data;

  BadResponseException([this.data]) : super();
}
