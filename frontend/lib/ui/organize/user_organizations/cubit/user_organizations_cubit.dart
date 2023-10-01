import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_organizations_state.dart';
part 'user_organizations_cubit.freezed.dart';

@injectable
class UserOrganizationsCubit extends Cubit<UserOrganizationsState> {
  UserOrganizationsCubit() : super(const UserOrganizationsState.idle());
}
