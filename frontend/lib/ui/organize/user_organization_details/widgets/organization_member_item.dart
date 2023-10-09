import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:flutter/material.dart';

class OrganizationMember extends StatelessWidget {
  const OrganizationMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  const AvatarIcon(altText: 'AS'),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User name'),
                        Text('User email'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
            const Text('Permissions: Test, Text'),
          ],
        ),
      ),
    );
  }
}
