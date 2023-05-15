// ignore_for_file: one_member_abstracts

import 'package:event_planr/data/network/models/user_dto.dart';

abstract class MessageApi {
  Future<List<UserDto>> getUsers();
}
