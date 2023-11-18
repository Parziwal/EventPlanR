import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_invite_reply.freezed.dart';

@freezed
class AddInviteReply with _$AddInviteReply {
  const factory AddInviteReply({
    required String invitationId,
    required bool accept,
  }) = _AddInviteReply;
}
