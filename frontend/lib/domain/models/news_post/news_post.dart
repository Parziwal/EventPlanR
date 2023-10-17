import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_post.freezed.dart';
part 'news_post.g.dart';

@freezed
class NewsPost with _$NewsPost {
  const factory NewsPost({
    required String text,
    required DateTime created,
  }) = _NewsPost;

  factory NewsPost.fromJson(Map<String, Object?> json) =>
      _$NewsPostFromJson(json);
}
