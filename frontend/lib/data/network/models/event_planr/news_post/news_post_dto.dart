import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_post_dto.freezed.dart';
part 'news_post_dto.g.dart';

@freezed
class NewsPostDto with _$NewsPostDto {
  const factory NewsPostDto({
    required String text,
    required DateTime created,
  }) = _NewsPostDto;

  factory NewsPostDto.fromJson(Map<String, Object?> json) =>
      _$NewsPostDtoFromJson(json);
}
