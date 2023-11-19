import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/organization_details/cubit/organization_details_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationDetailsPage extends StatelessWidget {
  const OrganizationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EventScaffold(
      title: l10n.organizationDetails,
      allowAnonymous: true,
      body: BlocConsumer<OrganizationDetailsCubit, OrganizationDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.organizationDetails != null) {
            return _mainContent(context, state.organizationDetails!);
          }

          return Container();
        },
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    OrganizationDetails organizationDetails,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: MaxWidthBox(
        maxWidth: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWrapper(imageUrl: organizationDetails.profileImageUrl),
            const SizedBox(height: 16),
            Center(
              child: Text(
                organizationDetails.name,
                style: theme.textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.organizationDetails_Description,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              organizationDetails.description ?? '-',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationDetailsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }
}
