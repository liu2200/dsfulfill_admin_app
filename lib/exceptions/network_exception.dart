import 'package:dsfulfill_cient_app/exceptions/http_exception.dart';

class NetworkException extends HttpException {
  NetworkException({String? message, int? code}) : super(message, code);
}
