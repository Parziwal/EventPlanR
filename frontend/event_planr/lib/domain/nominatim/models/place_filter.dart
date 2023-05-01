import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PlaceFilter extends Equatable {
  const PlaceFilter({this.query, this.city, this.limit});

  final String? query;
  final String? city;
  final int? limit;
  
  @override
  List<Object?> get props => [query, city, limit];
}
