import 'package:dio/dio.dart';
import 'package:event_planr/data/network/message_api.dart';
import 'package:event_planr/data/network/models/user_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'message_service.g.dart';

@RestApi()
abstract class MessageService implements MessageApi {
  @factoryMethod
  factory MessageService(Dio dio, {String baseUrl}) = _MessageService;

  @GET('/message/users')
  @override
  Future<List<UserDto>> getUsers();
}
