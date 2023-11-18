import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_invitation.freezed.dart';

@freezed
class CreateInvitation with _$CreateInvitation {
  const factory CreateInvitation({
    required String eventId,
    required String userEmail,
  }) = _CreateInvitation;
}
