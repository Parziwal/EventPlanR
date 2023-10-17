import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_tickets_state.dart';
part 'event_tickets_cubit.freezed.dart';

@injectable
class EventTicketsCubit extends Cubit<EventTicketsState> {
  EventTicketsCubit() : super(const EventTicketsState.initial());
}
