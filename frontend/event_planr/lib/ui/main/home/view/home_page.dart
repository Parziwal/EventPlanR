import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/domain/auth/auth.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/main/home/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthRepository repository = injector<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10.home),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
        ],
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Section(
                sectionName: l10.homeFollowing,
                children: const [
                  OrganizationCard(),
                  OrganizationCard(),
                  OrganizationCard(),
                ],
              ),
              const SizedBox(height: 10),
              Section(
                sectionName: l10.homeYourNextEvents,
                children: const [
                  EventCard(),
                  EventCard(),
                  EventCard(),
                ],
              ),
              const SizedBox(height: 10),
              Section(
                sectionName: l10.homeNearbyYou,
                children: const [
                  EventCard(),
                  EventCard(),
                  EventCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
