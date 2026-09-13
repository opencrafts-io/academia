import 'dart:async';

import 'package:academia/features/chirp/posts/posts.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Inline poll rendered inside a post card / detail view.
///
/// Reads the post from the enclosing [PostCubit] so optimistic vote changes
/// paint immediately, and listens to [FeedBloc] for [PollVoteError] to roll
/// back. Requires [PostCubit], [FeedBloc] and [ProfileBloc] in context.
class PollWidget extends StatelessWidget {
  const PollWidget({super.key});

  static const Duration barAnimation = Duration(milliseconds: 350);

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  /// Computes the next selection for a tap on [option] and dispatches both the
  /// optimistic update and the network event.
  ///
  /// Reads the post from the cubit at tap time rather than from the builder
  /// closure: the builder only rebuilds when the poll changes, so its `post`
  /// can be stale for like/comment counts.
  void _onOptionTap(BuildContext context, PollOption option) {
    final cubit = context.read<PostCubit>();
    final post = cubit.state;
    final poll = post.poll;
    if (poll == null) return;
    if (poll.isClosed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This poll has closed'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileLoadedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in to vote'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final current = poll.myVotes.toSet();
    final Set<int> next;
    if (poll.allowsMultiple) {
      next = Set.of(current);
      if (!next.remove(option.id)) next.add(option.id);
    } else {
      // Tapping the current choice retracts; tapping another replaces.
      next = current.contains(option.id) ? {} : {option.id};
    }
    if (next.length == current.length && next.containsAll(current)) return;

    final feedBloc = context.read<FeedBloc>();
    final voterId = profileState.profile.id;

    cubit.applyOptimisticVote(next.toList());
    if (next.isEmpty) {
      feedBloc.add(RetractPollVoteEvent(post: post, voterId: voterId));
    } else {
      feedBloc.add(
        VoteOnPollEvent(post: post, optionIds: next.toList(), voterId: voterId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedBloc, FeedState>(
      listenWhen: (_, s) => s is PollVoteError,
      listener: (context, state) {
        if (state is PollVoteError &&
            state.post.id == context.read<PostCubit>().state.id) {
          context.read<PostCubit>().rollbackPoll(state.post);
          _showError(context, 'Couldn\'t save your vote. Please try again.');
        }
      },
      child: BlocBuilder<PostCubit, Post>(
        buildWhen: (a, b) => a.poll != b.poll,
        builder: (context, post) {
          final poll = post.poll;
          if (poll == null) return const SizedBox.shrink();

          final profileState = context.read<ProfileBloc>().state;
          final isAuthor =
              profileState is ProfileLoadedState &&
              profileState.profile.id == post.authorId;

          return _PollBody(
            poll: poll,
            isAuthor: isAuthor,
            onOptionTap: (o) => _onOptionTap(context, o),
            onViewVotes: () => showPollVotersSheet(
              context,
              postCubit: context.read<PostCubit>(),
            ),
          );
        },
      ),
    );
  }
}

class _PollBody extends StatefulWidget {
  final Poll poll;
  final bool isAuthor;
  final ValueChanged<PollOption> onOptionTap;
  final VoidCallback onViewVotes;

  const _PollBody({
    required this.poll,
    required this.isAuthor,
    required this.onOptionTap,
    required this.onViewVotes,
  });

  @override
  State<_PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<_PollBody> {
  /// Fires once when the poll closes while on screen so the UI flips to
  /// results without waiting for an unrelated rebuild.
  Timer? _closeTimer;

  Poll get poll => widget.poll;

  @override
  void initState() {
    super.initState();
    _scheduleCloseTimer();
  }

  @override
  void didUpdateWidget(covariant _PollBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.poll.endsAt != widget.poll.endsAt) _scheduleCloseTimer();
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    super.dispose();
  }

  void _scheduleCloseTimer() {
    _closeTimer?.cancel();
    final endsAt = poll.endsAt;
    if (endsAt == null || poll.isClosed) return;
    final remaining = endsAt.difference(DateTime.now());
    // Timers far in the future are pointless (and Timer caps at ~24 days).
    if (remaining > const Duration(days: 1)) return;
    _closeTimer = Timer(remaining + const Duration(seconds: 1), () {
      if (mounted) setState(() {});
    });
  }

  String _votesLabel(int n) => n == 1 ? '1 vote' : '$n votes';

  String? _endsLabel() {
    final endsAt = poll.endsAt;
    if (endsAt == null) return null;
    if (poll.isClosed) return 'Final results';
    final d = endsAt.difference(DateTime.now());
    if (d.inDays >= 1) {
      final hours = d.inHours - d.inDays * 24;
      return hours > 0
          ? 'Ends in ${d.inDays}d ${hours}h'
          : 'Ends in ${d.inDays}d';
    }
    if (d.inHours >= 1) return 'Ends in ${d.inHours}h ${d.inMinutes % 60}m';
    return 'Ends in ${d.inMinutes.clamp(1, 59)}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final showResults = poll.showsResults;
    final percentages = poll.percentages;
    final canViewVotes = !poll.isAnonymous || widget.isAuthor;
    final endsLabel = _endsLabel();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            poll.question,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                poll.allowsMultiple
                    ? Icons.checklist_rounded
                    : Icons.radio_button_checked,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              Text(
                poll.allowsMultiple ? 'Multiple choice' : 'Single choice',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (poll.isAnonymous) ...[
                _dot(context),
                Icon(
                  Icons.visibility_off_outlined,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                Text(
                  'Anonymous',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (endsLabel != null) ...[
                _dot(context),
                Text(
                  endsLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: poll.isClosed
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: poll.isClosed ? FontWeight.bold : null,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          RepaintBoundary(
            child: Column(
              children: [
                for (final option in poll.sortedOptions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: PollOptionBar(
                      text: option.text,
                      fraction: showResults ? poll.fractionFor(option) : 0,
                      percent: percentages[option.id] ?? 0,
                      selected: poll.myVotes.contains(option.id),
                      showResults: showResults,
                      multiSelect: poll.allowsMultiple,
                      enabled: !poll.isClosed,
                      onTap: () => widget.onOptionTap(option),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _votesLabel(poll.totalVotes),
                  key: ValueKey(poll.totalVotes),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Spacer(),
              if (poll.hasVoted && !poll.isClosed && !poll.allowsMultiple)
                Text(
                  'Tap your choice to undo',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              if (canViewVotes)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: poll.totalVotes == 0 ? null : widget.onViewVotes,
                  icon: Icon(
                    poll.isAnonymous
                        ? Icons.lock_outline
                        : Icons.people_outline,
                    size: 16,
                  ),
                  label: const Text('View votes'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(BuildContext context) => Text(
    '•',
    style: Theme.of(context).textTheme.labelSmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    ),
  );
}

/// One option row. Before results are shown it is a plain tappable choice;
/// afterwards a fill bar animates from its previous width to [fraction].
class PollOptionBar extends StatelessWidget {
  final String text;

  /// 0.0 – 1.0 share of voters; drives the fill width.
  final double fraction;

  /// Integer percentage for the trailing label.
  final int percent;
  final bool selected;
  final bool showResults;
  final bool multiSelect;
  final bool enabled;
  final VoidCallback onTap;

  const PollOptionBar({
    super.key,
    required this.text,
    required this.fraction,
    required this.percent,
    required this.selected,
    required this.showResults,
    required this.multiSelect,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fillColor = selected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final borderColor = selected
        ? colorScheme.primary
        : colorScheme.outlineVariant;

    final IconData leadingIcon;
    if (multiSelect) {
      leadingIcon = selected
          ? Icons.check_box_rounded
          : Icons.check_box_outline_blank_rounded;
    } else {
      leadingIcon = selected
          ? Icons.radio_button_checked
          : Icons.radio_button_unchecked;
    }

    return Semantics(
      button: enabled,
      selected: selected,
      label: showResults ? '$text, $percent percent' : text,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
              color: colorScheme.surface,
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Animated fill. Tween end is the target so successive updates
                // animate from wherever the bar currently is.
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(end: fraction),
                      duration: PollWidget.barAnimation,
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return FractionallySizedBox(
                          widthFactor: value.clamp(0.0, 1.0),
                          child: ColoredBox(color: fillColor),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          leadingIcon,
                          key: ValueKey(leadingIcon),
                          size: 20,
                          color: selected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.4),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        ),
                        child: showResults
                            ? Text(
                                '$percent%',
                                key: ValueKey(percent),
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: selected
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                                ),
                              )
                            : const SizedBox.shrink(key: ValueKey('hidden')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
