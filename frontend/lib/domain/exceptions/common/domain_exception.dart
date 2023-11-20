import 'package:dio/dio.dart';

class DomainException extends DioException {
  DomainException({required this.title})
      : super(requestOptions: RequestOptions());

  final String title;
}
