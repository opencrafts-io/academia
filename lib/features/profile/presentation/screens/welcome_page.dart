import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Image.asset(
          "assets/illustrations/scene 15.png",
          width: 300,
          height: 300,
        ),
        Text(
          "We'd like to ask you a few questions before you continue to Academia.",
        ),
        Spacer(),
        FilledButton(onPressed: onNext, child: Text("Get Started")),
      ],
    );
  }
}
