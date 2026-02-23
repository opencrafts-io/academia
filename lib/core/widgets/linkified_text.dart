import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkifiedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextAlign textAlign;
  final bool selectable;
  final int? maxLines;
  final TextOverflow? overflow;

  const LinkifiedText({
    super.key,
    required this.text,
    this.style,
    this.linkStyle,
    this.textAlign = TextAlign.start,
    this.selectable = true,
    this.maxLines,
    this.overflow,
  });

  Future<void> _showExitWarning(BuildContext context, String url) async {
    final bool? proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('External Link'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You are about to leave the app and visit an external site:',
            ),
            const SizedBox(height: 12),
            Text(
              url,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please be aware that this could be a potentially unsecure site. Do you wish to continue?',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (proceed == true) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          debugPrint('Could not launch $url: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const Text('');

    final List<InlineSpan> spans = [];
    
    // Robust regex for URLs, including http, https, www, and IP addresses
    final RegExp urlRegExp = RegExp(
      r'((https?:\/\/|www\.)[^\s]+|(?:\d{1,3}\.){3}\d{1,3}(?::\d+)?(?:\/[^\s]*)?)',
      caseSensitive: false,
    );

    final matches = urlRegExp.allMatches(text);
    int lastMatchEnd = 0;

    final effectiveStyle = style ?? DefaultTextStyle.of(context).style;
    final effectiveLinkStyle = linkStyle ??
        effectiveStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w500,
        );

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
        ));
      }

      final url = match.group(0)!;
      var launchUrlStr = url;

      if (launchUrlStr.toLowerCase().startsWith('www.')) {
        launchUrlStr = 'https://$launchUrlStr';
      } else if (RegExp(r'^(\d{1,3}\.){3}\d{1,3}').hasMatch(launchUrlStr)) {
        launchUrlStr = 'http://$launchUrlStr';
      }

      spans.add(
        TextSpan(
          text: url,
          style: effectiveLinkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => _showExitWarning(context, launchUrlStr),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
      ));
    }

    if (selectable && maxLines == null) {
      return SelectableText.rich(
        TextSpan(
          children: spans,
          style: effectiveStyle,
        ),
        textAlign: textAlign,
      );
    }

    return Text.rich(
      TextSpan(
        children: spans,
        style: effectiveStyle,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
