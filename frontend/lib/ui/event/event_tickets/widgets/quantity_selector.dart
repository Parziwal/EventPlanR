import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 0;

  void _increase() {
    setState(() {
      _quantity += 1;
    });
  }

  void _decrease() {
    if (_quantity == 0) {
      return;
    }

    setState(() {
      _quantity -= 1;
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
            onPressed: _decrease,
            icon: const Icon(Icons.remove),
          ),
          Text(
            _quantity.toString(),
            style: theme.textTheme.titleLarge,
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
