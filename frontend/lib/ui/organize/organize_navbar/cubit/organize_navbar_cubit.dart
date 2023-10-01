import 'package:event_planr_app/env/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organize_navbar_state.dart';
part 'organize_navbar_cubit.freezed.dart';

@injectable
class OrganizeNavbarCubit extends Cubit<OrganizeNavbarState> {
  OrganizeNavbarCubit() : super(const OrganizeNavbarState.idle());

  String desktopTitle = '';

  void changeTitle(String? title) {
    if (title != null && title.isNotEmpty) {
      desktopTitle = title;
      emit(const OrganizeNavbarState.desktopTitleChanged());
      emit(const OrganizeNavbarState.idle());
    }
  }

  Future<void> logout() async {

  }
}
