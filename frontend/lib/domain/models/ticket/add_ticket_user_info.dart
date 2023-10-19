import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_ticket_user_info.freezed.dart';
part 'add_ticket_user_info.g.dart';

@freezed
class AddTicketUserInfo with _$AddTicketUserInfo {
  const factory AddTicketUserInfo({
    required String ticketId,
    required String userFirstName,
    required String userLastName,
  }) = _AddTicketUserInfo;

  factory AddTicketUserInfo.fromJson(Map<String, Object?> json) =>
      _$AddTicketUserInfoFromJson(json);
}
