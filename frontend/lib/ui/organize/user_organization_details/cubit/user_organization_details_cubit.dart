import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_organization_details_state.dart';
part 'user_organization_details_cubit.freezed.dart';

class UserOrganizationDetailsCubit extends Cubit<UserOrganizationDetailsState> {
  UserOrganizationDetailsCubit() : super(const UserOrganizationDetailsState.initial());
}
