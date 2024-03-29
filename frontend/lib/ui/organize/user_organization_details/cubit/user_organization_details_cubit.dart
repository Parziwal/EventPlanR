import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/organization/add_or_edit_organization_member.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/domain/organization_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'user_organization_details_state.dart';

part 'user_organization_details_cubit.freezed.dart';

@injectable
class UserOrganizationDetailsCubit extends Cubit<UserOrganizationDetailsState> {
  UserOrganizationDetailsCubit({
    required OrganizationManagerRepository organizationManagerRepository,
    required AuthRepository authRepository,
  })  : _organizationManagerRepository = organizationManagerRepository,
        _authRepository = authRepository,
        super(
          const UserOrganizationDetailsState(
            status: UserOrganizationDetailsStatus.idle,
          ),
        );

  final OrganizationManagerRepository _organizationManagerRepository;
  final AuthRepository _authRepository;

  Future<void> loadUserOrganizationDetails() async {
    try {
      emit(state.copyWith(status: UserOrganizationDetailsStatus.loading));
      final organizationDetails = await _organizationManagerRepository
          .getUserCurrentOrganizationDetails();
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.idle,
          organizationDetails: organizationDetails,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> deleteOrganization() async {
    try {
      emit(state.copyWith(status: UserOrganizationDetailsStatus.loading));
      await _organizationManagerRepository.deleteCurrentOrganization();
      await _authRepository.refreshToken();
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.organizationDeleted,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> addOrEditOrganizationMember(
    AddOrEditOrganizationMember member,
  ) async {
    try {
      emit(state.copyWith(status: UserOrganizationDetailsStatus.loading));
      await _organizationManagerRepository
          .addOrEditMemberToOrganization(member);
      await loadUserOrganizationDetails();
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> removeMemberFromOrganization(String memberUserId) async {
    try {
      emit(state.copyWith(status: UserOrganizationDetailsStatus.loading));
      await _organizationManagerRepository
          .removeMemberFromCurrentOrganization(memberUserId);
      await loadUserOrganizationDetails();
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> uploadOrganizationProfileImage(XFile image) async {
    try {
      emit(state.copyWith(status: UserOrganizationDetailsStatus.loading));
      final imageUrl = await _organizationManagerRepository
          .uploadOrganizationProfileImage(image);
      emit(
        state.copyWith(
          organizationDetails:
              state.organizationDetails!.copyWith(profileImageUrl: imageUrl),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationDetailsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserOrganizationDetailsStatus.idle));
  }
}
