import 'package:freezed_annotation/freezed_annotation.dart';

part 'sender.freezed.dart';

@freezed
class Sender with _$Sender {
  const factory Sender({
    required String id,
    required String firstName,
    required String lastName,
    String? profileImageUrl,
  }) = _Sender;
}
