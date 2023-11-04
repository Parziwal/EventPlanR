import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required DateTime lastMessageDate,
    required bool haveUnreadMessage,
    @Default('') String contactFirstName,
    @Default('') String contactLastName,
    @Default('') String eventName,
    String? profileImageUrl,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(Map<String, Object?> json) => _$ChatFromJson(json);

  String getName(BuildContext context) {
    if (eventName.isNotEmpty) {
      return eventName;
    }

    return context.l10n.localeName == 'hu'
        ? '$contactLastName $contactFirstName'
        : '$contactFirstName $contactLastName';
  }

  String getMonogram(BuildContext context) {
    if (eventName.isNotEmpty) {
      return eventName[0];
    }

    return context.l10n.localeName == 'hu'
        ? '${contactLastName[0]} ${contactFirstName[0]}'
        : '${contactFirstName[0]} ${contactLastName[0]}';
  }
}
