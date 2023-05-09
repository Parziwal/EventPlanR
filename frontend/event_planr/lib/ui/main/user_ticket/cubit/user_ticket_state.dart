part of 'user_ticket_cubit.dart';

abstract class UserTicketState extends Equatable {
  const UserTicketState();

  @override
  List<Object> get props => [];
}

class UserTicketLoading extends UserTicketState {}

class UserTicketList extends UserTicketState {
  const UserTicketList({required this.userTickets});

  final List<UserTicket> userTickets;

  @override
  List<Object> get props => [userTickets];
}
