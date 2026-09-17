import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PostVoteButton extends StatelessWidget {
  final int upvotes;
  final int downvotes;
  final int myVote;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const PostVoteButton({
    super.key,
    required this.upvotes,
    required this.downvotes,
    required this.myVote,
    required this.onUpvote,
    required this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: [
        ButtonSegment<int>(
          value: 1,
          icon: Icon(Symbols.shift_rounded),
          label: Text('${upvotes - downvotes}'),
        ),
        ButtonSegment<int>(
          value: -1,
          icon: RotatedBox(quarterTurns: 2, child: Icon(Symbols.shift_rounded)),
        ),
      ],
      emptySelectionAllowed: true,
      selected: myVote == 0 ? const <int>{} : <int>{myVote},
      showSelectedIcon: false,
      onSelectionChanged: (Set<int> newSelection) {
        if (newSelection.isEmpty) {
          if (myVote == 1) {
            onUpvote();
          } else if (myVote == -1) {
            onDownvote();
          }
        } else {
          final selected = newSelection.first;
          if (selected == 1) {
            onUpvote();
          } else if (selected == -1) {
            onDownvote();
          }
        }
      },
    );
    
  }
}
