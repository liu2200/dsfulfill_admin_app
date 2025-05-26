import 'package:dsfulfill_admin_app/exceptions/http_exception.dart';

class NetworkException extends HttpException {
  NetworkException({String? message, int? code}) : super(message, code);
}
