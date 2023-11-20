import 'package:dio/dio.dart';

class EntityNotFoundException extends DioException {
  EntityNotFoundException({required this.title})
      : super(requestOptions: RequestOptions());

  final String title;
}
