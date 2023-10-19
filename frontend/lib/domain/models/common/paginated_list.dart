import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_list.freezed.dart';

@freezed
class PaginatedList<T> with _$PaginatedList<T> {
  const factory PaginatedList({
    required List<T> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _PaginatedList;
}
