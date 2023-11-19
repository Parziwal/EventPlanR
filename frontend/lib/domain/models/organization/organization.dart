import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization.freezed.dart';

@freezed
class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    String? profileImageUrl,
    int? eventCount,
  }) = _Organization;
}
