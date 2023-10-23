part of 'organization_event_tickets_cubit.dart';

enum OrganizationEventTicketsStatus { idle, loading, error }

@freezed
class OrganizationEventTicketsState with _$OrganizationEventTicketsState {
  const factory OrganizationEventTicketsState({
    required OrganizationEventTicketsStatus status,
    String? eventId,
    List<OrganizationTicket>? tickets,
    String? errorCode,
  }) = _OrganizationEventTicketsState;
}
