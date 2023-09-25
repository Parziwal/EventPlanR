import 'package:event_planr_app/utils/responsive_widget.dart';
import 'package:event_planr_app/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';

class AuthResponsiveFrame extends StatelessWidget {
  const AuthResponsiveFrame({
    required this.child,
    required this.desktopHeight,
    super.key,
  });

  final Widget child;
  final double desktopHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ResponsiveWidget(
      desktopScreen: ColoredBox(
        color: theme.colorScheme.inversePrimary,
        child: SingleChildScrollView(
          child: MaxWidthBox(
            maxWidth: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 128),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: SizedBox(
                  height: desktopHeight,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
      mobileScreen: child,
    );
  }
}
