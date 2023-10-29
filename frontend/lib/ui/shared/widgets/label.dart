import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    required this.label,
    required this.value,
    this.textStyle,
    super.key,
  });

  final String label;
  final String value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textStyle,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
