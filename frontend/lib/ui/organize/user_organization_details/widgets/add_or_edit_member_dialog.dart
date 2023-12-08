import 'package:event_planr_app/domain/models/organization/add_or_edit_organization_member.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

Future<void> showAddOrEditMemberDialog(
  BuildContext context, {
  OrganizationMember? member,
}) {
  final userOrganizationDetailsCubit =
      context.read<UserOrganizationDetailsCubit>();

  return showDialog(
    context: context,
    builder: (contextModal) {
      return BlocProvider.value(
        value: userOrganizationDetailsCubit,
        child: Dialog(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          child: SizedBox(
            width: 600,
            height: 480,
            child: BlocBuilder<UserOrganizationDetailsCubit,
                UserOrganizationDetailsState>(
              builder: (context, state) => _AddOrEditMemberDialog(
                disabled: state.status == UserOrganizationDetailsStatus.loading,
                member: member,
                submit: (member) {
                  userOrganizationDetailsCubit
                      .addOrEditOrganizationMember(member);
                  context.pop();
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _AddOrEditMemberDialog extends StatefulWidget {
  const _AddOrEditMemberDialog({
    required this.submit,
    this.disabled = false,
    this.member,
  });

  final bool disabled;
  final OrganizationMember? member;
  final void Function(AddOrEditOrganizationMember member) submit;

  @override
  State<_AddOrEditMemberDialog> createState() => _AddOrEditMemberDialogState();
}

class _AddOrEditMemberDialogState extends State<_AddOrEditMemberDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final bool _edit;

  @override
  void initState() {
    super.initState();
    _edit = widget.member != null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: theme.colorScheme.inversePrimary,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _edit
                    ? l10n.userOrganizationDetails_EditMember
                    : l10n.userOrganizationDetails_AddMember,
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                'memberUserEmail': widget.member?.email,
                'memberUserId': widget.member?.id,
                'policies': widget.member?.organizationPolicies,
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _emailField(context),
                  const SizedBox(height: 16),
                  _organizationPermissionFields(context),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: !widget.disabled ? _submit : null,
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.titleMedium,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: Text(l10n.submit),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: !widget.disabled ? () => context.pop() : null,
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.titleMedium,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_edit) {
        widget.submit(
          AddOrEditOrganizationMember.fromJson({
            ..._formKey.currentState!.value,
            'memberUserEmail': null,
            'memberUserId': widget.member!.id,
          }),
        );
      } else {
        widget.submit(
          AddOrEditOrganizationMember.fromJson(
            _formKey.currentState!.value,
          ),
        );
      }
    }
  }

  Widget _emailField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'memberUserEmail',
      enabled: !widget.disabled && !_edit,
      decoration: InputDecoration(
        hintText: l10n.userOrganizationDetails_MemberEmail,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(128),
        ],
      ),
    );
  }

  Widget _organizationPermissionFields(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderCheckboxGroup(
      name: 'policies',
      enabled: !widget.disabled,
      options: [
        FormBuilderFieldOption(
          value: OrganizationPolicy.organizationView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.organizationView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.organizationManage,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.organizationManage),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.organizationEventView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.organizationEventView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.organizationEventManage,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.organizationEventManage),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.eventTicketView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.eventTicketView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.eventTicketManage,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.eventTicketManage),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.newsPostView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.newsPostView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.newsPostManage,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.newsPostManage),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.invitationView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.invitationView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.invitationManage,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.invitationManage),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.eventStatistics,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.eventStatistics),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.orderView,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.orderView),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.eventChat,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.eventChat),
          ),
        ),
        FormBuilderFieldOption(
          value: OrganizationPolicy.userCheckIn,
          child: Text(
            l10n.translateEnums(OrganizationPolicy.userCheckIn),
          ),
        ),
      ],
      orientation: OptionsOrientation.vertical,
      onChanged: (value) {
        if (value != null &&
            value.contains(OrganizationPolicy.organizationManage) &&
            !value.contains(OrganizationPolicy.organizationView)) {
          _formKey.currentState?.fields['policies']
              ?.setValue(value..add(OrganizationPolicy.organizationView));
        }
        if (value != null &&
            value.contains(OrganizationPolicy.organizationEventManage) &&
            !value.contains(OrganizationPolicy.organizationEventView)) {
          _formKey.currentState?.fields['policies']
              ?.setValue(value..add(OrganizationPolicy.organizationEventView));
        }
        if (value != null &&
            value.contains(OrganizationPolicy.eventTicketManage) &&
            !value.contains(OrganizationPolicy.eventTicketView)) {
          _formKey.currentState?.fields['policies']
              ?.setValue(value..add(OrganizationPolicy.eventTicketView));
        }
        if (value != null &&
            value.contains(OrganizationPolicy.invitationManage) &&
            !value.contains(OrganizationPolicy.invitationView)) {
          _formKey.currentState?.fields['policies']
              ?.setValue(value..add(OrganizationPolicy.invitationView));
        }
        if (value != null &&
            value.contains(OrganizationPolicy.newsPostManage) &&
            !value.contains(OrganizationPolicy.newsPostView)) {
          _formKey.currentState?.fields['policies']
              ?.setValue(value..add(OrganizationPolicy.newsPostView));
        }
      },
    );
  }
}
