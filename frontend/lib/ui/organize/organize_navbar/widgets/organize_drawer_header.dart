import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrganizeDrawerHeader extends StatelessWidget {
  const OrganizeDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<OrganizeNavbarCubit, OrganizeNavbarState>(
      builder: (context, state) {
        if (state.organization == null) {
          return Center(child: Text(l10n.organizeNavbarNoOrganizationSelected));
        }

        return InkWell(
          onTap: () => context.go(PagePaths.userOrganizationDetails),
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                AvatarIcon(
                  altText: state.organization!.name[0],
                  imageUrl: state.organization!.profileImageUrl,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    state.organization!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
