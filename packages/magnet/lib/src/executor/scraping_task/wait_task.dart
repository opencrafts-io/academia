// Copyright (C) 2026 Erick Muuo & Open Crafts Interactive Limited
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import "package:flutter_inappwebview/flutter_inappwebview.dart";
import "package:magnet/magnet.dart";

import "base_task.dart";

import 'dart:async';
import 'dart:convert';

/// Executes wait and synchronization strategies for scraping instructions.
///
/// Supports fixed delays and reactive waits such as URL changes,
/// DOM element presence, and network idleness.
class WaitTask implements ScrapingTask {
  static const _pollInterval = Duration(milliseconds: 300);

  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
    final strategy = instruction.waitStrategy;

    if (strategy != null) {
      await _executeWaitStrategy(controller, strategy);
    } else if (instruction.waitDuration != null) {
      await Future.delayed(instruction.waitDuration!);
    }

    return null;
  }

  /// Dispatches execution to the appropriate wait strategy.
  Future<void> _executeWaitStrategy(
    InAppWebViewController controller,
    WaitStrategy strategy,
  ) {
    return strategy.when(
      waitForUrl: (pattern, timeoutMs) =>
          _withTimeout(_waitForUrl(controller, pattern), timeoutMs),
      waitForElement: (selector, timeoutMs) =>
          _withTimeout(_waitForElement(controller, selector), timeoutMs),
      waitForElementDisappear: (selector, timeoutMs) => _withTimeout(
        _waitForElementDisappear(controller, selector),
        timeoutMs,
      ),
      waitForNetworkIdle: (timeoutMs, quietMs) =>
          _withTimeout(_waitForNetworkIdle(controller, quietMs), timeoutMs),
      waitForAny: (strategies, timeoutMs) =>
          _waitForAny(controller, strategies, timeoutMs),
      waitForAll: (strategies, timeoutMs) =>
          _waitForAll(controller, strategies, timeoutMs),
    );
  }

  /// Applies a hard timeout to a wait operation.
  Future<void> _withTimeout(Future<void> future, int timeoutMs) {
    return future.timeout(
      Duration(milliseconds: timeoutMs),
      onTimeout: () => throw TimeoutException(
        'Wait strategy timed out',
        Duration(milliseconds: timeoutMs),
      ),
    );
  }

  /// Waits until the current URL contains [pattern].
  Future<void> _waitForUrl(
    InAppWebViewController controller,
    String pattern,
  ) async {
    while (true) {
      final url = (await controller.getUrl())?.toString() ?? '';
      if (url.contains(pattern)) return;
      await Future.delayed(_pollInterval);
    }
  }

  /// Waits for a DOM element matching [selector] to appear.
  Future<void> _waitForElement(
    InAppWebViewController controller,
    String selector,
  ) async {
    final safeSelector = jsonEncode(selector);

    while (true) {
      final exists = await controller.evaluateJavascript(
        source:
            '''
          (function() {
            const selector = $safeSelector;
            return document.querySelector(selector) !== null;
          })()
        ''',
      );

      if (exists == true) return;
      await Future.delayed(_pollInterval);
    }
  }

  /// Waits for a DOM element matching [selector] to disappear.
  Future<void> _waitForElementDisappear(
    InAppWebViewController controller,
    String selector,
  ) async {
    final safeSelector = jsonEncode(selector);

    while (true) {
      final exists = await controller.evaluateJavascript(
        source:
            '''
          (function() {
            const selector = $safeSelector;
            return document.querySelector(selector) !== null;
          })()
        ''',
      );

      if (exists != true) return;
      await Future.delayed(_pollInterval);
    }
  }

  /// Waits until there are no active network requests for a quiet period.
  Future<void> _waitForNetworkIdle(
    InAppWebViewController controller,
    int quietDurationMs,
  ) async {
    await _injectNetworkMonitor(controller);

    final quietDuration = Duration(milliseconds: quietDurationMs);
    DateTime? idleSince;

    while (true) {
      final pending =
          await controller.evaluateJavascript(
                source: 'window.__pendingRequests ?? 0',
              )
              as num? ??
          0;

      if (pending == 0) {
        idleSince ??= DateTime.now();
        if (DateTime.now().difference(idleSince) >= quietDuration) return;
      } else {
        idleSince = null;
      }

      await Future.delayed(_pollInterval);
    }
  }

  /// Injects a safe, idempotent network activity tracker.
  Future<void> _injectNetworkMonitor(InAppWebViewController controller) async {
    await controller.evaluateJavascript(
      source: '''
        (function() {
          if (window.__networkMonitorInstalled) return;
          window.__networkMonitorInstalled = true;
          window.__pendingRequests = 0;

          const inc = () => window.__pendingRequests++;
          const dec = () => window.__pendingRequests = Math.max(0, window.__pendingRequests - 1);

          const originalFetch = window.fetch;
          window.fetch = function(...args) {
            inc();
            return originalFetch.apply(this, args).finally(dec);
          };

          const open = XMLHttpRequest.prototype.open;
          XMLHttpRequest.prototype.open = function() {
            inc();
            this.addEventListener('loadend', dec, { once: true });
            return open.apply(this, arguments);
          };
        })();
      ''',
    );
  }

  /// Waits until any strategy succeeds.
  Future<void> _waitForAny(
    InAppWebViewController controller,
    List<WaitStrategy> strategies,
    int timeoutMs,
  ) async {
    await Future.any(
      strategies.map((s) => _executeWaitStrategy(controller, s)),
    ).timeout(
      Duration(milliseconds: timeoutMs),
      onTimeout: () =>
          throw TimeoutException('All waitForAny strategies timed out'),
    );
  }

  /// Waits until all strategies succeed sequentially.
  Future<void> _waitForAll(
    InAppWebViewController controller,
    List<WaitStrategy> strategies,
    int timeoutMs,
  ) async {
    final deadline = DateTime.now().add(Duration(milliseconds: timeoutMs));

    for (final strategy in strategies) {
      final remaining = deadline.difference(DateTime.now()).inMilliseconds;

      if (remaining <= 0) {
        throw TimeoutException('waitForAll exceeded total timeout');
      }

      await _executeWaitStrategy(
        controller,
        strategy,
      ).timeout(Duration(milliseconds: remaining));
    }
  }
}
