import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_navigation_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(NavigationTab tab) => emit(HomeState(tab: tab));
}
