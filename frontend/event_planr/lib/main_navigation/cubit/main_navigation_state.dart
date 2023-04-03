part of 'main_navigation_cubit.dart';

enum NavigationTab { home, explore, event, message, profile }

class HomeState extends Equatable {
  const HomeState({
    this.tab = NavigationTab.home,
  });

  final NavigationTab tab;

  @override
  List<Object> get props => [tab];
}
