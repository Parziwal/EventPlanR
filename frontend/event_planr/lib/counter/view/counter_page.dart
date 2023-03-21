import 'dart:convert';

import 'package:event_planr/counter/counter.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final url = Uri.https(
      'localhost:53948',
      'event/list',
    );
    final response = http.get(url);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: FutureBuilder(
        future: response,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('An error occured!'),
              );
            } else {
              final data = jsonDecode(dataSnapshot.data!.body) as List<dynamic>;
              return ListView.builder(
                itemBuilder: (ctx, index) => ListTile(
                  leading: Image.network(data[index]["imageUrl"].toString()),
                  title: Text(data[index]["name"].toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]["type"].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(DateFormat('dd/MM/yyyyy hh:mm').format(
                          DateTime.parse(data[index]["date"].toString()))),
                      Text(data[index]["location"].toString())
                    ],
                  ),
                ),
                itemCount: data.length,
              );
            }
          }
        },
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
