import 'package:event_planr_app/domain/event_manager_repository.dart';
import 'package:event_planr_app/domain/models/common/chart_spot.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_statistics.dart';
import 'package:event_planr_app/domain/models/ticket/ticket_statistics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_statistics_state.dart';

part 'organization_event_statistics_cubit.freezed.dart';

@injectable
class OrganizationEventStatisticsCubit
    extends Cubit<OrganizationEventStatisticsState> {
  OrganizationEventStatisticsCubit({
    required EventManagerRepository eventManagerRepository,
  })  : _eventManagerRepository = eventManagerRepository,
        super(
          const OrganizationEventStatisticsState(
            status: OrganizationEventStatisticsStatus.idle,
          ),
        );

  final EventManagerRepository _eventManagerRepository;

  Future<void> loadEventStatistics(String eventId) async {
    try {
      emit(state.copyWith(status: OrganizationEventStatisticsStatus.loading));
      final eventStatistics =
          await _eventManagerRepository.getEventStatistics(eventId);
      emit(state.copyWith(eventStatistics: eventStatistics));
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventStatisticsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: OrganizationEventStatisticsStatus.idle));
  }
}
