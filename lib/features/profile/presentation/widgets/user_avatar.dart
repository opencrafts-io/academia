import 'package:core/core.dart';
import 'package:profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.radius = 20,
    this.shape = M3EShape.bun,
  });

  final double radius;
  final M3EShape shape;

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      final avatarUrl = state is ProfileLoadedState
          ? state.profile.avatarUrl?.trim()
          : null;
      final avatar = avatarUrl?.isNotEmpty == true
          ? CircleAvatar(
              radius: radius,
              backgroundImage: CachedNetworkImageProvider(avatarUrl!),
            )
          : CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person_rounded,
                size: radius * 1.2,
                color: Colors.white70,
              ),
            );

      return ClipPath(clipper: M3EShapeClipper(shape), child: avatar);
    },
  );
}
