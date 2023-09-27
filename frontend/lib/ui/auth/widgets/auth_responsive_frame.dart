import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
    final screenHeight = context.mediaQuery.size.height;

    return ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: child),
        Condition.largerThan(
          name: MOBILE,
          value: ColoredBox(
            color: theme.colorScheme.inversePrimary,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight > desktopHeight
                      ? (screenHeight - desktopHeight) / 2
                      : 0,
                ),
                child: MaxWidthBox(
                  alignment: Alignment.center,
                  maxWidth: 600,
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
        ),
      ],
    ).value!;
  }
}
