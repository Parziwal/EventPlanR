import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/domain/auth/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthRepository repository = injector<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: repository.user,
              builder: (context, snap) {
                return Column(
                  children: [
                    Text('User email: ${snap.data?.email}'),
                    Text('User name: ${snap.data?.name}'),
                  ],
                );
              },
            ),
            FutureBuilder(
              future: repository.bearerToken,
              builder: (context, snap) {
                return Column(
                  children: [
                    Text('Token: ${snap.data}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
