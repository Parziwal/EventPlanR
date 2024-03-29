import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';

class EventItemCardLandscape extends StatelessWidget {
  const EventItemCardLandscape({
    required this.event,
    required this.onPressed,
    super.key,
  });

  final Event event;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      height: 150,
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
                imageUrl: event.coverImageUrl,
                aspectRatio: 1,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatEventDateTimeRange(
                          context,
                          event.fromDate,
                          event.toDate,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.name,
                        style: theme.textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.group,
                                size: theme.textTheme.labelLarge!.fontSize,
                                color: theme.colorScheme.secondary,
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 10),
                            ),
                            TextSpan(text: event.organizationName),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.location_on_outlined,
                                size: theme.textTheme.labelLarge!.fontSize,
                                color: theme.colorScheme.secondary,
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 10),
                            ),
                            TextSpan(text: event.venue),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.secondary,
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
