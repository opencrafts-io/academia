import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        AnimatedEmoji(AnimatedEmojis.smile, size: 200),
        Text(
          "Hi, there stranger!",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          "We'd like to know you better before you continue to Academia. ❤️‍🔥",
          textAlign: TextAlign.center,
        ),
        Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(padding: EdgeInsets.all(22)),
          onPressed: onNext,

          child: Text("Get Started"),
        ),
      ],
    );
  }
}
