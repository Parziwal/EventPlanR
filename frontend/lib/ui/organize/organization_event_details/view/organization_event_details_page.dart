import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organization_event_details/cubit/organization_event_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/ui/shared/widgets/image_picker_item.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/ui/shared/widgets/static_map.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventDetailsPage extends StatelessWidget {
  const OrganizationEventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final goRouterState = context.goRouterState;
    final eventDetails =
        context.watch<OrganizationEventDetailsCubit>().state.eventDetails;
    final user = context.watch<OrganizeNavbarCubit>().state.user;

    return OrganizeScaffold(
      title: l10n.organizationEventDetails,
      showActions: user != null &&
          user.organizationPolicies
              .contains(OrganizationPolicy.organizationEventManage),
      mobileActions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: () =>
                  context.read<OrganizationEventDetailsCubit>().publishEvent(),
              child: Text(
                eventDetails != null && eventDetails.isPublished
                    ? l10n.organizationEventDetails_UnPublishEvent
                    : l10n.organizationEventDetails_PublishEvent,
              ),
            ),
            PopupMenuItem<void>(
              onTap: () => context.go(
                PagePaths.organizationEventEdit(
                  goRouterState.pathParameters['eventId']!,
                ),
              ),
              child: Text(l10n.organizationEventDetails_EditEvent),
            ),
            PopupMenuItem<void>(
              onTap: () => _deleteEvent(context),
              child: Text(l10n.organizationEventDetails_DeleteEvent),
            ),
          ],
        ),
      ],
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () =>
              context.read<OrganizationEventDetailsCubit>().publishEvent(),
          icon: const Icon(Icons.publish),
          label: Text(
            eventDetails != null && eventDetails.isPublished
                ? l10n.organizationEventDetails_UnPublishEvent
                : l10n.organizationEventDetails_PublishEvent,
          ),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton.tonalIcon(
          onPressed: () => context.go(
            PagePaths.organizationEventEdit(
              goRouterState.pathParameters['eventId']!,
            ),
          ),
          icon: const Icon(Icons.edit),
          label: Text(l10n.organizationEventDetails_EditEvent),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton.tonalIcon(
          onPressed: () => _deleteEvent(context),
          icon: const Icon(Icons.delete),
          label: Text(l10n.organizationEventDetails_DeleteEvent),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: BlocConsumer<OrganizationEventDetailsCubit,
          OrganizationEventDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationEventDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.eventDetails != null) {
            return _mainContent(context, state.eventDetails!);
          }

          return Text(state.status.name);
        },
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    OrganizationEventDetails eventDetails,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MaxWidthBox(
        maxWidth: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePickerItem(
              imagePicked: (file) => context
                  .read<OrganizationEventDetailsCubit>()
                  .uploadEventCoverImage(file),
              imageUrl: eventDetails.coverImageUrl,
            ),
            const SizedBox(height: 16),
            Text(
              eventDetails.name,
              style: theme.textTheme.headlineLarge,
            ),
            Text(
              l10n.translateEnums(eventDetails.category.name),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                formatEventDetailsDateRange(
                  context,
                  eventDetails.fromDate,
                  eventDetails.toDate,
                ),
              ),
              subtitle: Text(
                formatEventDetailsTimeRange(
                  context,
                  eventDetails.fromDate,
                  eventDetails.toDate,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(eventDetails.venue),
              subtitle: Text(eventDetails.address.formatToString()),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: StaticMap(location: eventDetails.coordinates),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.organizationEventDetails_About,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              eventDetails.description ?? '-',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.organizationEventDetails_Currency(
                l10n.translateEnums(eventDetails.currency.name),
              ),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              eventDetails.isPrivate
                  ? l10n.organizationEventDetails_VisibilityPrivateEvent
                  : l10n.organizationEventDetails_VisibilityPublicEvent,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            Text(
              l10n.organizationEventDetails_Created(
                eventDetails.createdBy ?? '-',
                DateFormat.yMMMMEEEEd(l10n.localeName)
                    .format(eventDetails.created),
              ),
              style: theme.textTheme.titleMedium,
            ),
            Text(
              l10n.organizationEventDetails_LastModified(
                eventDetails.lastModifiedBy ?? '-',
                DateFormat.yMMMMEEEEd(l10n.localeName)
                    .format(eventDetails.lastModified),
              ),
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventDetailsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.exception!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    } else if (state.status == OrganizationEventDetailsStatus.eventPublished) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.eventDetails!.isPublished
                  ? l10n.organizationEventDetails_EventPublished
                  : l10n.organizationEventDetails_EventUnPublished,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    } else if (state.status == OrganizationEventDetailsStatus.eventDeleted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.organizationEventDetails_EventDeleted,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.go(PagePaths.organizationEvents);
    }
  }

  void _deleteEvent(BuildContext context) {
    final l10n = context.l10n;
    final eventDetails =
        context.read<OrganizationEventDetailsCubit>().state.eventDetails;

    if (eventDetails != null) {
      showConfirmationDialog(
        context,
        message: l10n.organizationEventDetails_AreYouSureYouWantToDeleteEvent(
          eventDetails.name,
        ),
      ).then((value) {
        if (value ?? false) {
          context.read<OrganizationEventDetailsCubit>().deleteEvent();
        }
      });
    }
  }
}
