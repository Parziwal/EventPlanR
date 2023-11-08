part of 'organization_event_orders_cubit.dart';

@freezed
class OrganizationEventOrdersState with _$OrganizationEventOrdersState {
  const factory OrganizationEventOrdersState({
    List<EventOrder>? eventOrders,
    int? pageNumber,
    String? errorCode,
  }) = _OrganizationEventOrdersState;
}
