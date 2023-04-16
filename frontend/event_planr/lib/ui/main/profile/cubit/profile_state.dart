part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends Equatable {
}

class ProfileIdle extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLogoutComplete extends ProfileState {
  @override
  List<Object?> get props => [];
}
