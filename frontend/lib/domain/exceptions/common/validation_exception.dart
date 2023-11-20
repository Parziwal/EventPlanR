import 'package:dio/dio.dart';

class ValidationException extends DioException {
  ValidationException() : super(requestOptions: RequestOptions());

  @override
  String toString() {
    return 'ValidationException';
  }
}
