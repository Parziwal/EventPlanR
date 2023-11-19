import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class OrganizationItemCardLandscape extends StatelessWidget {
  const OrganizationItemCardLandscape({
    required this.organization,
    required this.onPressed,
    super.key,
  });

  final Organization organization;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return SizedBox(
      height: 120,
      width: 450,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageWrapper(
                imageUrl: organization.profileImageUrl,
                aspectRatio: 1,
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        organization.name,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.events}: ${organization.eventCount}',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
