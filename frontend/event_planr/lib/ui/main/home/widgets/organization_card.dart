import 'package:flutter/material.dart';

class OrganizationCard extends StatelessWidget {
  const OrganizationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 100,
              child: Image.network(
                'https://placehold.co/600x500.png',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'Organization name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
