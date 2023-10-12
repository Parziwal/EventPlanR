import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_events_state.dart';
part 'organization_events_cubit.freezed.dart';

class OrganizationEventsCubit extends Cubit<OrganizationEventsState> {
  OrganizationEventsCubit() : super(const OrganizationEventsState.initial());
}