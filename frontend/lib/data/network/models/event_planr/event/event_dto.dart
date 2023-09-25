import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

@freezed
class EventDto with _$EventDto {
  const factory EventDto({
    required String id,
    required String name,
    required int category,
    required DateTime fromDate,
    required String venue,
    required String? coverImageUrl,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, Object?> json) =>
      _$EventDtoFromJson(json);
}
