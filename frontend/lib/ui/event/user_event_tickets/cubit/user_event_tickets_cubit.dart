import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/domain/user_ticket_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event_tickets_state.dart';

part 'user_event_tickets_cubit.freezed.dart';

@injectable
class UserEventTicketsCubit extends Cubit<UserEventTicketsState> {
  UserEventTicketsCubit({
    required UserTicketRepository userTicketRepository,
  })  : _userTicketRepository = userTicketRepository,
        super(
          const UserEventTicketsState(status: UserEventTicketsStatus.idle),
        );

  final UserTicketRepository _userTicketRepository;

  Future<void> loadUserEventTickets(String eventId) async {
    try {
      emit(state.copyWith(status: UserEventTicketsStatus.loading));
      final soldTickets = await _userTicketRepository.getUserEventTickets(
        eventId,
      );
      emit(state.copyWith(soldTickets: soldTickets));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserEventTicketsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserEventTicketsStatus.idle));
  }
}
