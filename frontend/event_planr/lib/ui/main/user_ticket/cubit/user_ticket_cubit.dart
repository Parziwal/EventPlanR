import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/ticket/models/user_ticket.dart';
import 'package:event_planr/domain/ticket/ticket_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_ticket_state.dart';

@injectable
class UserTicketCubit extends Cubit<UserTicketState> {
  UserTicketCubit(
    this.ticketRepository,
    this.authRepository,
  ) : super(UserTicketLoading());

  final TicketRepository ticketRepository;
  final AuthRepository authRepository;

  Future<void> getUserTickets(String eventId) async {
    emit(UserTicketLoading());
    final user = await authRepository.user;
    final tickets = await ticketRepository.getUserEvents(eventId, user.sub);
    emit(UserTicketList(userTickets: tickets));
  }
}
