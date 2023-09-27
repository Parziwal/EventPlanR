import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_navbar_state.dart';

part 'event_navbar_cubit.freezed.dart';

@injectable
class EventNavbarCubit extends Cubit<EventNavbarState> {
  EventNavbarCubit() : super(const EventNavbarState.none());

  void changeAppBar(AppBar? appBar) {
    if (appBar != null) {
      emit(EventNavbarState.appBarChanged(appBar));
    } else {
      removeAppBar();
    }
  }

  void removeAppBar() {
    emit(const EventNavbarState.none());
  }
}
