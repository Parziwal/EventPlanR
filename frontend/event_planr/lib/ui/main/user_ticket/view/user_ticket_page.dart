import 'package:event_planr/domain/ticket/models/user_ticket.dart';
import 'package:event_planr/ui/main/user_ticket/cubit/user_ticket_cubit.dart';
import 'package:event_planr/ui/shared/loading.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserTicketPage extends StatelessWidget {
  const UserTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
      ),
      body: BlocBuilder<UserTicketCubit, UserTicketState>(
        builder: (context, state) {
          if (state is UserTicketLoading) {
            return const Loading();
          } else if (state is UserTicketList) {
            return PageView.builder(
              itemCount: state.userTickets.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Text('${index + 1}/${state.userTickets.length}'),
                  const SizedBox(height: 8),
                  Flexible(
                    child: _ticketWidget(context, state.userTickets[index]),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _ticketWidget(BuildContext context, UserTicket ticket) {
    return Column(
      children: [
        Text(
          ticket.ticketName,
          style: context.theme.textTheme.titleLarge,
        ),
        Text(
          'Quantity: ${ticket.quantity}',
          style: context.theme.textTheme.titleMedium,
        ),
        Flexible(
          child: Center(
            child: PrettyQr(
              typeNumber: 3,
              size: 300,
              data: ticket.id,
              roundEdges: true,
              elementColor: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
