import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_news_post.freezed.dart';
part 'organization_news_post.g.dart';

@freezed
class OrganizationNewsPost with _$OrganizationNewsPost {
  const factory OrganizationNewsPost({
    required String id,
    required String title,
    required DateTime created,
    required DateTime lastModified,
    required String text,
    String? createdBy,
    String? lastModifiedBy,
  }) = _OrganizationNewsPost;

  factory OrganizationNewsPost.fromJson(Map<String, Object?> json) =>
      _$OrganizationNewsPostFromJson(json);
}
