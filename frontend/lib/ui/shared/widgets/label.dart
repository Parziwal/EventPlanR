import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    required this.label,
    required this.value,
    this.textStyle,
    this.backgroundColor,
    super.key,
  });

  final String label;
  final String value;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: Row(
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
      ),
    );
  }
}
