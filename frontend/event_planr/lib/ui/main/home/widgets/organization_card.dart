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
                'https://picsum.photos/id/399/600/500.jpg',
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
