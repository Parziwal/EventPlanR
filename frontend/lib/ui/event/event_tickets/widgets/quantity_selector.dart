import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    required this.maxCount,
    required this.ticketAdded,
    required this.ticketRemoved,
    this.disabled = false,
    super.key,
  });

  final bool disabled;
  final int maxCount;
  final void Function() ticketAdded;
  final void Function() ticketRemoved;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 0;

  void _increase() {
    if (_quantity >= widget.maxCount) {
      return;
    }

    setState(() {
      _quantity += 1;
      widget.ticketAdded();
    });
  }

  void _decrease() {
    if (_quantity == 0) {
      return;
    }

    setState(() {
      _quantity -= 1;
      widget.ticketRemoved();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: !widget.disabled ? _decrease : null,
            icon: const Icon(Icons.remove),
          ),
          Text(
            _quantity.toString(),
            style: theme.textTheme.titleLarge,
          ),
          IconButton(
            onPressed: !widget.disabled ? _increase : null,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
