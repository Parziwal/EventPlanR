import 'package:event_planr/ui/main/event_ticket/cubit/event_ticket_cubit.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({required this.ticketName, super.key});

  final String ticketName;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 0;

  void _increase() {
    context.read<EventTicketCubit>().addTicket(widget.ticketName);
    setState(() {
      _quantity += 1;
    });
  }

  void _decrease() {
    if (_quantity == 0) {
      return;
    }
    context.read<EventTicketCubit>().removeTicket(widget.ticketName);
    setState(() {
      _quantity -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _decrease,
            icon: const Icon(Icons.remove),
          ),
          Text(
            _quantity.toString(),
            style: context.theme.textTheme.titleLarge,
          ),
          IconButton(
            onPressed: _increase,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
