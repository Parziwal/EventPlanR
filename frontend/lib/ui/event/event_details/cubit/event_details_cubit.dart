import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_details_state.dart';
part 'event_details_cubit.freezed.dart';

@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit() : super(const EventDetailsState.initial());
}
