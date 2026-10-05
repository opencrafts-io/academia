import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:magnet/magnet.dart';
import 'package:portal_sync/portal_sync.dart';

import '../widgets/portal_connection_card.dart';
import '../widgets/portal_import_review.dart';
import '../widgets/portal_progress_overview.dart';
import '../widgets/portal_state_message.dart';

/// Student-facing portal connection, browsing, and review experience.
class PortalSyncPage extends StatefulWidget {
  const PortalSyncPage({
    required this.connection,
    required this.controller,
    this.onUpgrade,
    super.key,
  });

  final PortalConnection connection;
  final PortalSyncController controller;
  final VoidCallback? onUpgrade;

  @override
  State<PortalSyncPage> createState() => _PortalSyncPageState();
}

class _PortalSyncPageState extends State<PortalSyncPage> {
  InAppWebViewController? _webController;
  PortalBrowserObserver? _observer;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  bool _connected = false;
  bool _browserReady = false;
  bool _onSignInPage = false;
  bool _browserLoadFailed = false;
  String? _captureNotice;
  Uri? _currentUri;

  @override
  void initState() {
    super.initState();
    _currentUri = widget.connection.portalUri;
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant PortalSyncPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
      _observer?.dispose();
      _observer = null;
      _webController = null;
      _browserReady = false;
    }
    if (oldWidget.connection != widget.connection) {
      _currentUri = widget.connection.portalUri;
      _connected = false;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _observer?.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  void _connect(Uri uri) {
    final next = PortalConnection(
      accountId: widget.connection.accountId,
      institutionId: widget.connection.institutionId,
      schoolName: widget.connection.schoolName,
      portalUri: uri,
    );
    widget.controller.setConnection(next);
    setState(() {
      _currentUri = uri;
      _connected = true;
      _captureNotice = null;
    });
    widget.controller.resume();
  }

  void _pauseChecking() {
    _observer?.pause();
    widget.controller.pause();
  }

  Future<void> _resumeChecking() async {
    widget.controller.resume();
    await _observer?.resume();
  }

  Future<void> _stopSync() async {
    if (widget.controller.state.draft != null) {
      final discard = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Stop and discard this review?'),
          content: const Text(
            'The courses and class times in this preview have not been saved.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Keep reviewing'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Stop sync'),
            ),
          ],
        ),
      );
      if (discard != true || !mounted) return;
    }
    _observer?.stop();
    widget.controller.stop();
    setState(() {
      _connected = false;
      _browserReady = false;
      _onSignInPage = false;
      _browserLoadFailed = false;
      _captureNotice = null;
    });
  }

  void _onWebViewCreated(InAppWebViewController webController) {
    _webController = webController;
    _observer?.dispose();
    _observer = PortalBrowserObserver(
      controller: webController,
      allowedOrigins: {
        _portalOrigin(_currentUri ?? widget.connection.portalUri),
      },
      onSnapshot: (rawSnapshot) {
        try {
          unawaited(
            widget.controller.capture(PortalSnapshot.fromJson(rawSnapshot)),
          );
        } on Object catch (error, stack) {
          portalDebugLog('snapshot.invalid', error: error, stackTrace: stack);
        }
      },
      onHint: (notice) {
        if (mounted) {
          portalDebugLog(
            notice == null ? 'capture.complete' : 'capture.partial',
          );
          setState(() => _captureNotice = notice);
        }
      },
    );
    unawaited(_observer!.start());
  }

  String _portalOrigin(Uri uri) =>
      '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';

  Future<void> _captureCurrentPage() async {
    final observer = _observer;
    if (observer == null) return;
    final rawSnapshot = await observer.capture();
    if (rawSnapshot != null) {
      try {
        await widget.controller.capture(PortalSnapshot.fromJson(rawSnapshot));
      } on Object catch (error, stack) {
        portalDebugLog('snapshot.invalid', error: error, stackTrace: stack);
      }
    }
  }

  Future<void> _reload() async {
    await _webController?.reload();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;
        final media = MediaQuery.of(context);
        final wide = media.size.width >= 960;
        final content = _connected
            ? _buildBrowser(context, wide: wide)
            : _buildSetup(context);

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.connection.schoolName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'School portal',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            actions: [
              if (_connected) ...[
                IconButton(
                  tooltip: 'Reload portal page',
                  onPressed: _reload,
                  icon: const Icon(Icons.refresh_rounded),
                ),
                if (state.phase == PortalSyncPhase.paused)
                  IconButton(
                    tooltip: 'Resume checking',
                    onPressed: _resumeChecking,
                    icon: const Icon(Icons.play_circle_outline_rounded),
                  )
                else
                  IconButton(
                    tooltip: 'Pause checking',
                    onPressed: _pauseChecking,
                    icon: const Icon(Icons.pause_circle_outline_rounded),
                  ),
                IconButton(
                  tooltip: 'Stop portal sync',
                  onPressed: _stopSync,
                  icon: const Icon(Icons.stop_circle_outlined),
                ),
              ],
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(top: false, child: content),
        );
      },
    );
  }

  Widget _buildSetup(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width >= 840 ? 680 : 560),
          child: Column(
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 48,
                  color: colors.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Bring your class schedule together',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in to your school portal and review the courses and class times you want to save.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              PortalConnectionCard(
                initialUri: _currentUri ?? widget.connection.portalUri,
                schoolName: widget.connection.schoolName,
                isBusy: widget.controller.state.isBusy,
                errorMessage: _connectionError(widget.controller.state),
                onConnect: _connect,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _connectionError(PortalSyncState state) {
    if (state.accessDenied) {
      return 'Your plan does not include portal checks. Upgrade to continue.';
    }
    if (state.phase == PortalSyncPhase.error) {
      return state.error ??
          'We could not prepare this portal. Check the address and try again.';
    }
    return null;
  }

  Widget _buildBrowser(BuildContext context, {required bool wide}) {
    final colors = Theme.of(context).colorScheme;
    final browser = ClipRRect(
      borderRadius: BorderRadius.circular(wide ? 28 : 0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(_currentUri.toString())),
            initialSettings: InAppWebViewSettings(
              incognito: true,
              javaScriptEnabled: true,
              useShouldOverrideUrlLoading: true,
              supportZoom: true,
              transparentBackground: false,
              mediaPlaybackRequiresUserGesture: true,
              allowsInlineMediaPlayback: true,
              mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
              allowFileAccess: false,
              allowContentAccess: false,
              allowFileAccessFromFileURLs: false,
              allowUniversalAccessFromFileURLs: false,
            ),
            onWebViewCreated: _onWebViewCreated,
            onLoadStart: (_, uri) {
              if (mounted) {
                setState(() {
                  _browserReady = false;
                  _browserLoadFailed = false;
                  _onSignInPage = _isSignInUri(uri);
                });
                _observer?.stop();
              }
            },
            onLoadStop: (_, uri) async {
              if (!mounted) return;
              setState(() {
                _browserReady = true;
                _onSignInPage = _isSignInUri(uri);
              });
              await _observer?.start();
              await _captureCurrentPage();
            },
            onReceivedError: (_, request, error) {
              if (request.isForMainFrame == true && mounted) {
                setState(() {
                  _browserReady = true;
                  _browserLoadFailed = true;
                });
              }
            },
            shouldOverrideUrlLoading: (_, action) async {
              final uri = action.request.url;
              if (uri == null ||
                  uri.scheme.toLowerCase() != 'https' ||
                  uri.userInfo.isNotEmpty) {
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
          ),
          if (!_browserReady)
            ColoredBox(
              color: colors.surface,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Opening ${widget.connection.schoolName}…',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );

    if (wide) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 7, child: browser),
            const SizedBox(width: 20),
            SizedBox(
              width: 360,
              child: _assistantPanel(context, expanded: true),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(child: browser),
        DraggableScrollableSheet(
          initialChildSize: .26,
          minChildSize: .15,
          maxChildSize: .88,
          controller: _sheetController,
          snap: true,
          snapSizes: const [.26, .56],
          builder: (context, scrollController) => _assistantPanel(
            context,
            scrollController: scrollController,
            expanded: false,
          ),
        ),
      ],
    );
  }

  bool _isSignInUri(WebUri? webUri) {
    final path = webUri?.path.toLowerCase() ?? '';
    return RegExp(
      r'(^|[/_-])(login|log-in|sign-in|signin|oauth|authorize|mfa)([/_-]|$)',
    ).hasMatch(path);
  }

  Widget _assistantPanel(
    BuildContext context, {
    ScrollController? scrollController,
    required bool expanded,
  }) {
    final theme = Theme.of(context);
    final state = widget.controller.state;
    return Material(
      color: theme.colorScheme.surfaceContainer,
      elevation: 3,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!expanded)
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Portal assistant',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (state.isBusy)
                        const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _assistantHint(state),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.accessDenied)
                    PortalStateMessage(
                      title: 'Portal checks are unavailable',
                      message: state.message ?? 'Upgrade your plan to check for new course information.',
                      icon: Icons.lock_outline_rounded,
                      actionLabel: 'View plans',
                      onAction: widget.onUpgrade,
                    )
                  else if (_browserLoadFailed)
                    PortalStateMessage(
                      title: 'Portal page didn’t load',
                      message: 'Check your internet connection, then reload the page.',
                      icon: Icons.cloud_off_rounded,
                      isError: true,
                      actionLabel: 'Reload page',
                      onAction: _reload,
                    )
                  else if (_onSignInPage)
                    const PortalStateMessage(
                      title: 'Sign in to continue',
                      message: 'Use the school portal below. Academia will continue when you open an academic page.',
                      icon: Icons.lock_outline_rounded,
                    )
                  else if (state.phase == PortalSyncPhase.paused)
                    PortalStateMessage(
                      title: 'Checking is paused',
                      message: 'Your portal remains open. Resume when you want Academia to look for updates.',
                      icon: Icons.pause_circle_outline_rounded,
                      actionLabel: 'Resume',
                      onAction: _resumeChecking,
                    )
                  else if (state.phase == PortalSyncPhase.error)
                    PortalStateMessage(
                      title: _errorTitle(state),
                      message:
                          state.error ??
                          state.message ??
                          'Check your connection and try again.',
                      icon: Icons.sync_problem_rounded,
                      isError: true,
                      actionLabel: state.draft == null
                          ? 'Try again'
                          : 'Save again',
                      onAction: state.draft == null
                          ? widget.controller.retryAnalysis
                          : widget.controller.saveDraft,
                    )
                  else if (state.phase == PortalSyncPhase.blocked)
                    PortalStateMessage(
                      title: _blockedTitle(state),
                      message:
                          state.message ??
                          'Open your course list or timetable to continue.',
                      icon: _blockedIcon(state),
                    )
                  else
                    PortalStateMessage(
                      title: state.phase == PortalSyncPhase.saved
                          ? 'Your information is saved'
                          : 'Browse your portal',
                      message: state.message ?? 'Sign in as usual, then open your course list or timetable.',
                      icon: state.phase == PortalSyncPhase.saved
                          ? Icons.check_circle_outline_rounded
                          : Icons.touch_app_rounded,
                    ),
                  const SizedBox(height: 14),
                  PortalProgressOverview(
                    coursesCount: state.coursesCount,
                    meetingsCount: state.meetingsCount,
                    fromCache: state.fromCache,
                  ),
                  if (_captureNotice != null) ...[
                    const SizedBox(height: 12),
                    _CaptureNoticeCard(message: _captureNotice!),
                  ],
                  if (state.draft != null &&
                      state.phase != PortalSyncPhase.saved) ...[
                    const SizedBox(height: 14),
                    PortalImportReview(
                      draft: state.draft!,
                      isBusy: state.isBusy,
                      onSave: widget.controller.saveDraft,
                      onDiscard: widget.controller.discard,
                    ),
                  ],
                  if (state.hintLabel?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 14),
                    _HintCard(
                      label: state.hintLabel!,
                      onShow: state.hintNodeId == null
                          ? null
                          : () async {
                              if (!expanded && _sheetController.isAttached) {
                                final reduceMotion =
                                    MediaQuery.disableAnimationsOf(context);
                                if (reduceMotion) {
                                  _sheetController.jumpTo(.15);
                                } else {
                                  await _sheetController.animateTo(
                                    .15,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOutCubic,
                                  );
                                }
                              }
                              await _observer?.highlight(state.hintNodeId!);
                            },
                    ),
                  ],
                  if (state.draft == null &&
                      state.phase != PortalSyncPhase.saved) ...[
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: state.isBusy ? null : _captureCurrentPage,
                        icon: const Icon(Icons.search_rounded),
                        label: const Text('Check this page'),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _assistantHint(PortalSyncState state) {
    if (_browserLoadFailed) {
      return 'Check your internet connection and reload the page.';
    }
    if (_onSignInPage) return 'Sign in with your school in the page below.';
    switch (state.phase) {
      case PortalSyncPhase.analyzing:
        return 'Looking at visible course information…';
      case PortalSyncPhase.saving:
        return 'Saving the information you reviewed…';
      case PortalSyncPhase.review:
        return 'Take a moment to check these details.';
      case PortalSyncPhase.paused:
        return 'You can browse without checks running.';
      default:
        return 'Your sign-in stays in the school portal.';
    }
  }

  String _errorTitle(PortalSyncState state) {
    if ((state.error ?? state.message)?.toLowerCase().contains('offline') ??
        false) {
      return 'You’re offline';
    }
    if ((state.error ?? state.message)?.toLowerCase().contains('session') ??
        false) {
      return 'Portal session ended';
    }
    return 'We couldn’t check this page';
  }

  String _blockedTitle(PortalSyncState state) {
    if (state.message?.toLowerCase().contains('limit') ?? false) {
      return 'Portal check limit reached';
    }
    return 'Open a course or timetable page';
  }

  IconData _blockedIcon(PortalSyncState state) {
    if (state.message?.toLowerCase().contains('limit') ?? false) {
      return Icons.hourglass_bottom_rounded;
    }
    return Icons.travel_explore_rounded;
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({required this.label, this.onShow});
  final String label;
  final VoidCallback? onShow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ListTile(
        leading: Icon(
          Icons.lightbulb_outline_rounded,
          color: theme.colorScheme.onSecondaryContainer,
        ),
        title: const Text('Try this next'),
        subtitle: Text(
          label,
          style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
        ),
        trailing: onShow == null
            ? null
            : IconButton(
                tooltip: 'Show this part of the page',
                onPressed: onShow,
                icon: const Icon(Icons.center_focus_strong_rounded),
              ),
      ),
    );
  }
}

class _CaptureNoticeCard extends StatelessWidget {
  const _CaptureNoticeCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      liveRegion: true,
      child: Card(
        color: theme.colorScheme.secondaryContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            color: theme.colorScheme.onSecondaryContainer,
          ),
          title: const Text('Part of this page was captured'),
          subtitle: Text(
            message,
            style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
          ),
        ),
      ),
    );
  }
}
