import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_post.freezed.dart';

@freezed
class NewsPost with _$NewsPost {
  const factory NewsPost({
    required String text,
    required DateTime created,
  }) = _NewsPost;
}
