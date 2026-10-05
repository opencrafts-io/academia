import 'package:flutter/material.dart';

/// A short, readable setup form for connecting a student supplied portal URL.
///
/// The URL is deliberately restricted to HTTPS and cannot contain credentials.
/// The caller remains responsible for applying its institution and account IDs.
class PortalConnectionCard extends StatefulWidget {
  const PortalConnectionCard({
    required this.initialUri,
    required this.schoolName,
    required this.onConnect,
    this.isBusy = false,
    this.errorMessage,
    super.key,
  });

  final Uri initialUri;
  final String schoolName;
  final ValueChanged<Uri> onConnect;
  final bool isBusy;
  final String? errorMessage;

  @override
  State<PortalConnectionCard> createState() => _PortalConnectionCardState();
}

class _PortalConnectionCardState extends State<PortalConnectionCard> {
  late final TextEditingController _urlController;
  final _formKey = GlobalKey<FormState>();
  bool _showPrivacyDetails = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUri.toString());
  }

  @override
  void didUpdateWidget(covariant PortalConnectionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialUri != widget.initialUri &&
        _urlController.text != widget.initialUri.toString()) {
      _urlController.text = widget.initialUri.toString();
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Uri? _validatedUri(String? value) {
    final raw = value?.trim() ?? '';
    final uri = Uri.tryParse(raw);
    if (uri == null || !uri.hasAuthority || uri.host.isEmpty) return null;
    if (uri.scheme.toLowerCase() != 'https') return null;
    if (uri.userInfo.isNotEmpty) return null;
    return uri;
  }

  void _connect() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final uri = _validatedUri(_urlController.text);
    if (uri != null) widget.onConnect(uri);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final motionOff = MediaQuery.disableAnimationsOf(context);

    return Card(
      color: colors.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.account_balance_rounded,
                      color: colors.onPrimaryContainer,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect your school portal',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Use the secure website you normally visit for ${widget.schoolName}.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _urlController,
                enabled: !widget.isBusy,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                enableSuggestions: false,
                onFieldSubmitted: (_) => _connect(),
                decoration: const InputDecoration(
                  labelText: 'Portal website',
                  hintText: 'https://portal.yourschool.edu',
                  prefixIcon: Icon(Icons.language_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validatedUri(value) == null
                    ? 'Enter a valid HTTPS website address.'
                    : null,
              ),
              if (widget.errorMessage != null) ...[
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    widget.errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              AnimatedSize(
                duration: motionOff
                    ? Duration.zero
                    : const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minTileHeight: 48,
                      leading: Icon(
                        Icons.lock_outline_rounded,
                        color: colors.tertiary,
                      ),
                      title: const Text('Your sign-in stays with your school'),
                      subtitle: const Text(
                        'Cloud AI reads page labels to find courses and class times. Course rows stay on this device until you save them.',
                      ),
                      trailing: IconButton(
                        tooltip: _showPrivacyDetails
                            ? 'Hide details'
                            : 'Privacy details',
                        onPressed: () => setState(
                          () => _showPrivacyDetails = !_showPrivacyDetails,
                        ),
                        icon: Icon(
                          _showPrivacyDetails
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                        ),
                      ),
                    ),
                    if (_showPrivacyDetails)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 48,
                          right: 8,
                          bottom: 12,
                        ),
                        child: Text(
                          'Cloud AI reads page labels, headings, table headers, and page types to find courses and class times. Course rows stay on this device until you save them. Your password and cookies are not captured.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: widget.isBusy ? null : _connect,
                  icon: widget.isBusy
                      ? SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.onPrimary,
                          ),
                        )
                      : const Icon(Icons.open_in_browser_rounded),
                  label: Text(
                    widget.isBusy
                        ? 'Preparing portal…'
                        : 'Start sync and open portal',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'You stay in control. Nothing is imported until you review it.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
