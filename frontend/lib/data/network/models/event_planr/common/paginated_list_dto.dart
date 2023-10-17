import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_list_dto.freezed.dart';
part 'paginated_list_dto.g.dart';

@freezed
class PaginatedListDto with _$PaginatedListDto {
  const factory PaginatedListDto({
    required List<Map<String, dynamic>> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
}) = _PaginatedListDto;

  factory PaginatedListDto.fromJson(Map<String, Object?> json) =>
      _$PaginatedListDtoFromJson(json);
}
