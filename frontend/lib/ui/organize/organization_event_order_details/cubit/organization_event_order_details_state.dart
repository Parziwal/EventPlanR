part of 'organization_event_order_details_cubit.dart';

enum OrganizationEventOrderDetailsStatus { idle, loading, error }

@freezed
class OrganizationEventOrderDetailsState
    with _$OrganizationEventOrderDetailsState {
  const factory OrganizationEventOrderDetailsState({
    required OrganizationEventOrderDetailsStatus status,
    OrderDetails? orderDetails,
    Exception? exception,
  }) = _OrganizationEventOrderDetailsState;
}
