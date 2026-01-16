import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InstitutionNotSupportedView extends StatelessWidget {
  const InstitutionNotSupportedView({super.key});

  Future<void> _sendRequestEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@opencrafts.io',
      query: 'subject=Access Request: Institution Support',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          // Visual anchor - Large Icon or Illustration placeholder
          Icon(
            Icons.domain_disabled_rounded,
            size: 80,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            "Snap!",
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "It seems your institution is not supported at the moment.",
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "We are constantly expanding our reach. If you'd like to see your institution's features here, let us know and we'll prioritize it.",
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
          ),
          const Spacer(flex: 2),
          // M3 Large Filled Button for primary action
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton.icon(
              onPressed: _sendRequestEmail,
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text("Request support"),
            ),
          ),
          const SizedBox(height: 16),
          // Subtle back action
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Go back"),
            ),
          ),
        ],
      ),
    );
  }
}
