import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ResponsiveWidget extends StatelessWidget {

  const ResponsiveWidget({
    required this.desktopScreen,
    super.key,
    this.tabletScreen,
    this.mobileScreen,
  });

  final Widget desktopScreen;
  final Widget? tabletScreen;
  final Widget? mobileScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = ResponsiveBreakpoints.of(context);
        if (breakpoint.equals(DESKTOP)) {
          return desktopScreen;
        } else if (breakpoint.equals(TABLET)) {
          return tabletScreen ?? desktopScreen;
        } else {
          return mobileScreen ?? desktopScreen;
        }
      },
    );
  }
}
