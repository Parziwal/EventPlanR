import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/domain/models/organization/organization_public_event_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_details_state.dart';

part 'organization_details_cubit.freezed.dart';

@injectable
class OrganizationDetailsCubit extends Cubit<OrganizationDetailsState> {
  OrganizationDetailsCubit({
    required EventGeneralRepository eventGeneralRepository,
  })  : _eventGeneralRepository = eventGeneralRepository,
        super(
          const OrganizationDetailsState(
            status: OrganizationDetailsStatus.idle,
          ),
        );

  final EventGeneralRepository _eventGeneralRepository;

  Future<void> loadOrganizationDetails(String organizationId) async {
    try {
      emit(state.copyWith(status: OrganizationDetailsStatus.loading));
      final organization =
          await _eventGeneralRepository.getOrganizationDetails(organizationId);
      emit(state.copyWith(organizationDetails: organization));
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: OrganizationDetailsStatus.idle));
  }

  Future<void> getOrganizationEvents({
    required int pageNumber,
    required String organizationId,
  }) async {
    try {
      emit(
        state.copyWith(
          events: pageNumber == 1 ? null : state.events,
        ),
      );
      final events = await _eventGeneralRepository.getOrganizationEvents(
        OrganizationPublicEventFilter(
          organizationId: organizationId,
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...state.events!, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }
  }
}
