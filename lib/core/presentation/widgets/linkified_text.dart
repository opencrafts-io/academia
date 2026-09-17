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

  /// Strips trailing characters that are almost never *meant* to be part of
  /// a URL even though `[^\s]+` happily swallows them - sentence punctuation
  /// glued right onto the end ("visit https://x.com.", "see (https://x.com)")
  /// and unmatched closing brackets/parens/quotes. A closing bracket is only
  /// stripped if the URL doesn't already contain its matching opener (so
  /// `https://en.wikipedia.org/wiki/Foo_(bar)` is left intact).
  static String _stripTrailingPunctuation(String url) {
    const trailingChars = '.,;:!?\'"';
    const pairs = {')': '(', ']': '[', '}': '{'};

    var end = url.length;
    while (end > 0) {
      final char = url[end - 1];
      if (trailingChars.contains(char)) {
        end--;
        continue;
      }
      final opening = pairs[char];
      if (opening != null) {
        final scanned = url.substring(0, end);
        final closingCount = char.allMatches(scanned).length;
        final openingCount = opening.allMatches(scanned).length;
        if (closingCount > openingCount) {
          end--;
          continue;
        }
      }
      break;
    }
    return url.substring(0, end);
  }

  Future<void> _showExitWarning(BuildContext context, String url) async {
    final colorScheme = Theme.of(context).colorScheme;
    final bool? proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.open_in_new_rounded, color: colorScheme.primary),
        title: const Text('Open external link?', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("You'll leave Academia to open this link:"),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                url,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Only open links you trust.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: const Text('Open'),
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
    final effectiveLinkStyle =
        linkStyle ??
        effectiveStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w500,
        );

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final rawUrl = match.group(0)!;
      final url = _stripTrailingPunctuation(rawUrl);
      final linkEnd = match.end - (rawUrl.length - url.length);
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
      lastMatchEnd = linkEnd;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    if (selectable && maxLines == null) {
      return SelectableText.rich(
        TextSpan(children: spans, style: effectiveStyle),
        textAlign: textAlign,
      );
    }

    return Text.rich(
      TextSpan(children: spans, style: effectiveStyle),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
