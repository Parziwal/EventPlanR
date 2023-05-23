import 'package:event_planr/domain/nominatim/models/place.dart';
import 'package:event_planr/ui/main/explore/cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSearchDelegate extends SearchDelegate<Place?> {
  LocationSearchDelegate(this.locationCubit);

  final LocationCubit locationCubit;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Search term must be longer than two letters.',
            ),
          )
        ],
      );
    }
    
    locationCubit.getPlaces(query);

    return BlocProvider.value(
      value: locationCubit,
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(state.places[index].displayName),
                onTap: () => close(context, state.places[index]),
              );
            },
            itemCount: state.places.length,
          );
        },
      ),
    );
  }
}
