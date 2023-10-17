import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String message,
}) async {
  final l10n = context.l10n;

  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
      actions: [
        FilledButton(
          onPressed: () => context.pop(true),
          child: Text(l10n.yes),
        ),
        OutlinedButton(
          onPressed: () => context.pop(false),
          child: Text(l10n.no),
        ),
      ],
    ),
  );
}
