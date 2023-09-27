import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_bottom_navbar.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_drawer_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventNavbar extends StatefulWidget {
  const EventNavbar({required this.child, super.key});

  final Widget child;

  @override
  State<EventNavbar> createState() => _EventNavbarState();
}

class _EventNavbarState extends State<EventNavbar> {
  @override
  void initState() {
    super.initState();

    GoRouter.of(context).routeInformationProvider.addListener(() {
      context.read<EventNavbarCubit>().removeAppBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveValue<Widget>(
      context,
      conditionalValues: [
        Condition.equals(
          name: MOBILE,
          value: EventBottomNavbar(
            child: widget.child,
          ),
        ),
        Condition.largerThan(
          name: MOBILE,
          value: EventDrawerNavbar(
            child: widget.child,
          ),
        ),
      ],
    ).value!;
  }
}
