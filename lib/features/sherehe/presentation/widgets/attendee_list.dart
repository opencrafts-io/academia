import 'package:academia/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatefulWidget {
  final String eventId;
  final String organizerId;
  final String? userId;

  const AttendeesList({
    super.key,
    required this.eventId,
    required this.organizerId,
    this.userId,
  });

  @override
  State<AttendeesList> createState() => _AttendeesListState();
}

class _AttendeesListState extends State<AttendeesList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendeeBloc>().add(FetchAttendees(eventId: widget.eventId));
    });
  }

  bool _isAttendeeHost(Attendee attendee) {
    if (widget.userId != null && widget.userId == widget.organizerId) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendeeBloc, AttendeeState>(
      builder: (context, state) {
        if (state is AttendeeLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: SpinningScallopIndicator()),
          );
        } else if (state is AttendeeError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Failed to load attendees. Please try again later.",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        } else if (state is AttendeeLoaded) {
          if (state.attendees.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Don't be boring,be the first to say you're going!",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final attendee = state.attendees[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: AttendeeCard(
                    attendee: attendee,
                    isHost: _isAttendeeHost(attendee),
                  ),
                );
              }, childCount: state.attendees.length),
            );
          }
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
