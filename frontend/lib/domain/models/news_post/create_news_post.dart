import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_news_post.freezed.dart';
part 'create_news_post.g.dart';

@freezed
class CreateNewsPost with _$CreateNewsPost {
  const factory CreateNewsPost({
    required String eventId,
    required String title,
    required String text,
  }) = _CreateNewsPost;

  factory CreateNewsPost.fromJson(Map<String, Object?> json)
    => _$CreateNewsPostFromJson(json);
}
