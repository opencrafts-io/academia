/// Orders replay suspension and restoration even if a route closes mid-startup.
class PortalReplayGuard {
  PortalReplayGuard({
    required this.isActive,
    required this.stop,
    required this.resume,
  });
  final Future<bool> Function() isActive;
  final Future<void> Function() stop;
  final Future<void> Function() resume;
  Future<void>? _entering;
  Future<void>? _exiting;
  bool _wasActive = false;

  Future<void> enter() {
    if (_exiting != null) {
      return Future.error(StateError('Portal session closed.'));
    }
    return _entering ??= _suspend();
  }

  Future<void> _suspend() async {
    _wasActive = await isActive();
    if (!_wasActive) return;
    await stop();
    if (await isActive()) {
      throw StateError('Could not prepare a private portal session.');
    }
  }

  Future<void> exit() => _exiting ??= _restore();

  Future<void> _restore() async {
    try {
      await _entering;
    } catch (_) {
      /* Restore original replay state after failure. */
    }
    if (_wasActive) await resume();
  }
}
