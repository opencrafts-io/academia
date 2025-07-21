import 'package:flutter/material.dart';

class OnboardingSuccessPage extends StatefulWidget {
  const OnboardingSuccessPage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<OnboardingSuccessPage> createState() => _OnboardingSuccessPageState();
}

class _OnboardingSuccessPageState extends State<OnboardingSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        Text(
          "Whoa! Thats it for now we'll keep this in mind",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        FilledButton(onPressed: widget.onNext, child: Text("Get started")),
      ],
    );
  }
}
