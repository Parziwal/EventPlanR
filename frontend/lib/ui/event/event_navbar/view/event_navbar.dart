import 'package:event_planr_app/ui/event/event_navbar/view/event_bottom_navbar.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_drawer_navbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventNavbar extends StatelessWidget {
  const EventNavbar({
    required this.child,
    required this.desktopTitle,
    super.key,
  });

  final Widget child;
  final String desktopTitle;

  @override
  Widget build(BuildContext context) {
    return ResponsiveValue<Widget>(
      context,
      conditionalValues: [
        Condition.equals(
          name: MOBILE,
          value: EventBottomNavbar(
            child: child,
          ),
        ),
        Condition.largerThan(
          name: MOBILE,
          value: EventDrawerNavbar(
            desktopTitle: desktopTitle,
            child: child,
          ),
        ),
      ],
    ).value!;
  }
}
