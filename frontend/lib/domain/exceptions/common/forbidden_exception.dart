import 'package:dio/dio.dart';

class ForbiddenException extends DioException {
  ForbiddenException() : super(requestOptions: RequestOptions());

  @override
  String toString() {
    return 'ForbiddenException';
  }
}
