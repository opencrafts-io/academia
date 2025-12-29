import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

/// The scrapping execution engine
///
/// The [ScrappingExecutor] digests and executes both commands and
//  instructions passed to the engine.
class ScrappingExecutor {
  final InAppWebViewController controller;
  final Logger logger;
  final Map<String, dynamic> extractedData = {};

  ScrappingExecutor({required this.controller, required this.logger});

  /// Runs [instruction] against the current webpage
  Future<void> execute(ScrapingInstruction instruction) async {
    switch (instruction.type) {
      case "extract":
        await _extract(instruction);
        break;
      case "wait":
        if (instruction.waitStrategy != null) {
          await _executeWaitStrategy(instruction.waitStrategy!);
        } else if (instruction.waitDuration != null) {
          await _wait(instruction);
        }
        break;
      case 'click':
        await _click(instruction);
        if (instruction.shouldWaitAfterExecution) {
          await _executeWaitStrategy(instruction.waitStrategy!);
        }
        break;
      case 'fill-form':
        _fillForm(instruction);
        if (instruction.shouldWaitAfterExecution) {
          await _executeWaitStrategy(instruction.waitStrategy!);
        }
        break;
      default:
        throw Exception("Unkown instruction type: [${instruction.type}]");
    }
  }

  /// Fills a form widget selected by selector with a value
  Future<void> _fillForm(ScrapingInstruction instruction) async {
    final selector = instruction.selector;
    final value = instruction.value;

    if (selector == null || value == null) {
      throw Exception('FillForm requires selector and value');
    }

    await controller.evaluateJavascript(
      source:
          '''
        (function() {
          const el = document.querySelector('$selector');
          if (el) {
            el.value = '$value';
            el.dispatchEvent(new Event('change', { bubbles: true }));
            el.dispatchEvent(new Event('input', { bubbles: true }));
          }
        })()
      ''',
    );
    logger.i('Filled form: $selector');
  }

  /// Clicks an element specified by its selector
  Future<void> _click(ScrapingInstruction instruction) async {
    final selector = instruction.selector;
    if (selector == null) throw Exception('Click requires selector');

    await controller.evaluateJavascript(
      source:
          '''
        (function() {
          document.querySelector('$selector')?.click();
        })()
      ''',
    );
    logger.i('Clicked: $selector');
  }

  /// Waits for a specified instruction duration otherwise wait for a second
  Future<void> _wait(ScrapingInstruction instruction) async {
    final duration = instruction.waitDuration ?? const Duration(seconds: 1);
    await Future.delayed(duration);
    logger.i('Waited ${duration.inMilliseconds}ms');
  }

  Future<void> _extract(ScrapingInstruction instruction) async {
    if (instruction.outputKey == null) {
      throw Exception('Extract requires a valid outputKey');
    }
    if (instruction.selectorToUse == '') {
      throw Exception("Extract requires a valid selector to use");
    }
    final outputKey = instruction.outputKey;

    String jsCode;
    if (instruction.isXPath) {
      jsCode = _buildXPathQueryExtractor(
        instruction.xpath!,
        instruction.attribute,
      );
    } else {
      jsCode = _buildCSSQueryExtractor(
        instruction.selector!,
        instruction.attribute,
      );
    }

    final result = await controller.evaluateJavascript(source: jsCode);
    extractedData[outputKey!] = result;
    logger.i('Extracted $outputKey: $result');
  }

  String _buildCSSQueryExtractor(String selector, String? attribute) {
    if (attribute == null) {
      return '''(function() {
      const el = document.querySelector('$selector');
      return el ? el.innerText.trim() : null;
    })()''';
    } else {
      return '''(function() {
      const el = document.querySelector('$selector');
      return el ? el.getAttribute('$attribute') : null;
    })()''';
    }
  }

  String _buildXPathQueryExtractor(String xpath, String? attribute) {
    if (attribute == null) {
      return '''const el = (function getElementByXPath() {
          return document.evaluate('$xpath', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      })();
      el? el.innerText.trim(): null;
      ''';
    }
    return '''const el = (function getElementByXPath() {
          return document.evaluate('$xpath', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      })();
      el ? el.getAttribute('$attribute') : null;
      ''';
  }

  /// Execute a wait strategy using pattern matching
  Future<void> _executeWaitStrategy(WaitStrategy strategy) async {
    await strategy.when(
      waitForUrl: (pattern, timeoutMs) => _waitForUrl(pattern, timeoutMs),
      waitForElement: (selector, timeoutMs) =>
          _waitForElement(selector, timeoutMs),
      waitForElementDisappear: (selector, timeoutMs) =>
          _waitForElementDisappear(selector, timeoutMs),
      waitForNetworkIdle: (timeoutMs, quietDurationMs) =>
          _waitForNetworkIdle(timeoutMs, quietDurationMs),
      waitForAny: (strategies, timeoutMs) =>
          _waitForAnyStrategy(strategies, timeoutMs),
      waitForAll: (strategies, timeoutMs) =>
          _waitForAllStrategy(strategies, timeoutMs),
    );
  }

  /// Wait for URL to match a pattern
  Future<void> _waitForUrl(String pattern, int timeoutMs) async {
    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);

    logger.d(
      'Waiting for URL pattern: $pattern (timeout: ${timeout.inSeconds}s)',
    );

    while (stopwatch.elapsed < timeout) {
      try {
        final currentUrl = await controller.getUrl();
        final urlString = currentUrl?.toString() ?? '';

        if (urlString.contains(pattern)) {
          logger.i('URL pattern matched: $pattern');
          stopwatch.stop();
          return;
        }

        logger.d('Current URL: $urlString (waiting for: $pattern)');
      } catch (e) {
        logger.w('Error checking URL: $e');
      }

      await Future.delayed(const Duration(milliseconds: 500));
    }

    stopwatch.stop();
    logger.w(
      'Timeout waiting for URL pattern: $pattern after ${stopwatch.elapsed.inSeconds}s',
    );
  }

  /// Wait for DOM element to appear
  Future<void> _waitForElement(String selector, int timeoutMs) async {
    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);

    logger.d('Waiting for element: $selector (timeout: ${timeout.inSeconds}s)');

    while (stopwatch.elapsed < timeout) {
      try {
        final exists = await controller.evaluateJavascript(
          source:
              '''
            (function() {
              const el = document.querySelector('$selector');
              return el !== null && el !== undefined;
            })()
          ''',
        );

        if (exists == true) {
          logger.d('Element appeared: $selector');
          stopwatch.stop();
          return;
        }

        logger.d('Element not found yet: $selector');
      } catch (e) {
        logger.w('Error checking element: $e');
      }

      await Future.delayed(const Duration(milliseconds: 500));
    }

    stopwatch.stop();
    logger.w(
      'Timeout waiting for element: $selector after ${stopwatch.elapsed.inSeconds}s',
    );
  }

  /// Wait for DOM element to disappear (useful for loading spinners)
  Future<void> _waitForElementDisappear(String selector, int timeoutMs) async {
    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);

    logger.d(
      'Waiting for element to disappear: $selector (timeout: ${timeout.inSeconds}s)',
    );

    while (stopwatch.elapsed < timeout) {
      try {
        final exists = await controller.evaluateJavascript(
          source:
              '''
            (function() {
              const el = document.querySelector('$selector');
              return el !== null && el !== undefined;
            })()
          ''',
        );

        if (exists != true) {
          logger.d('Element disappeared: $selector');
          stopwatch.stop();
          return;
        }

        logger.d('Element still present: $selector');
      } catch (e) {
        logger.w('Error checking element: $e');
      }

      await Future.delayed(const Duration(milliseconds: 500));
    }

    stopwatch.stop();
    logger.w(
      'Timeout waiting for element to disappear: $selector after ${stopwatch.elapsed.inSeconds}s',
    );
  }

  /// Wait for network to be idle (all fetch/XHR requests completed)
  Future<void> _waitForNetworkIdle(int timeoutMs, int quietDurationMs) async {
    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);
    final quietDuration = Duration(milliseconds: quietDurationMs);

    logger.d(
      'Waiting for network idle (timeout: ${timeout.inSeconds}s, quiet: ${quietDuration.inMilliseconds}ms)',
    );

    // Inject network monitoring script on first call
    await _injectNetworkMonitoring();

    int lastPendingRequests = 0;
    DateTime lastActivityTime = DateTime.now();

    while (stopwatch.elapsed < timeout) {
      try {
        final result = await controller.evaluateJavascript(
          source: 'window._magnet_pendingRequests || 0',
        );

        final pendingRequests = (result as num?)?.toInt() ?? 0;

        if (pendingRequests == 0) {
          final timeSinceLastActivity = DateTime.now().difference(
            lastActivityTime,
          );

          if (timeSinceLastActivity >= quietDuration) {
            logger.d(
              'Network idle (pending: $pendingRequests, quiet for: ${timeSinceLastActivity.inMilliseconds}ms)',
            );
            stopwatch.stop();
            return;
          } else {
            logger.d(
              'Network quiet but not long enough (${timeSinceLastActivity.inMilliseconds}/${quietDuration.inMilliseconds}ms)',
            );
          }
        } else {
          if (pendingRequests != lastPendingRequests) {
            logger.d('Pending requests: $pendingRequests');
            lastPendingRequests = pendingRequests;
          }
          lastActivityTime = DateTime.now();
        }
      } catch (e) {
        logger.w('Error checking network: $e');
      }

      await Future.delayed(const Duration(milliseconds: 200));
    }

    stopwatch.stop();
    logger.w(
      'Timeout waiting for network idle after ${stopwatch.elapsed.inSeconds}s',
    );
  }

  /// Inject network monitoring script into page
  Future<void> _injectNetworkMonitoring() async {
    try {
      await controller.evaluateJavascript(
        source: '''
          if (!window._magnet_networkInjected) {
            window._magnet_pendingRequests = 0;
            window._magnet_networkInjected = true;

            // Monitor fetch requests
            const originalFetch = window.fetch;
            window.fetch = function(...args) {
              window._magnet_pendingRequests++;
              return originalFetch.apply(this, args)
                .then(response => {
                  window._magnet_pendingRequests--;
                  return response;
                })
                .catch(error => {
                  window._magnet_pendingRequests--;
                  throw error;
                });
            };

            // Monitor XMLHttpRequest
            const originalOpen = XMLHttpRequest.prototype.open;
            XMLHttpRequest.prototype.open = function(method, url, ...rest) {
              window._magnet_pendingRequests++;

              const originalOnReadyStateChange = this.onreadystatechange;
              this.onreadystatechange = function() {
                if (this.readyState === 4) {
                  window._magnet_pendingRequests--;
                }
                if (originalOnReadyStateChange) {
                  originalOnReadyStateChange.call(this);
                }
              };

              // Also handle addEventListener for readystatechange
              const originalAddEventListener = this.addEventListener;
              this.addEventListener = function(event, handler, ...args) {
                if (event === 'readystatechange') {
                  return originalAddEventListener.call(this, event, function() {
                    if (this.readyState === 4) {
                      window._magnet_pendingRequests--;
                    }
                    return handler.call(this);
                  }, ...args);
                }
                return originalAddEventListener.call(this, event, handler, ...args);
              };

              return originalOpen.call(this, method, url, ...rest);
            };
          }
        ''',
      );
    } catch (e) {
      logger.w('Failed to inject network monitoring: $e');
    }
  }

  /// Wait for ANY strategy to succeed (first one wins)
  Future<void> _waitForAnyStrategy(
    List<WaitStrategy> strategies,
    int timeoutMs,
  ) async {
    logger.d(
      'Waiting for ANY of ${strategies.length} strategies (timeout: ${timeoutMs ~/ 1000}s)',
    );

    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);

    // Create futures for all strategies
    final futures = strategies.map((strategy) async {
      try {
        await _executeWaitStrategy(strategy);
        return true;
      } catch (e) {
        return false;
      }
    }).toList();

    try {
      // Race all strategies - first to complete wins
      await Future.any(futures).timeout(
        timeout,
        onTimeout: () {
          throw TimeoutException('All wait strategies timed out', timeout);
        },
      );

      stopwatch.stop();
      logger.d(
        'One strategy succeeded after ${stopwatch.elapsed.inSeconds}s',
      );
    } on TimeoutException {
      stopwatch.stop();
      logger.w(
        'All strategies timed out after ${stopwatch.elapsed.inSeconds}s',
      );
    } catch (e) {
      stopwatch.stop();
      logger.w('Error in waitForAny: $e');
    }
  }

  /// Wait for ALL strategies to succeed
  Future<void> _waitForAllStrategy(
    List<WaitStrategy> strategies,
    int timeoutMs,
  ) async {
    logger.d(
      'Waiting for ALL of ${strategies.length} strategies (timeout: ${timeoutMs ~/ 1000}s)',
    );

    final stopwatch = Stopwatch()..start();
    final timeout = Duration(milliseconds: timeoutMs);

    int completed = 0;

    try {
      for (final (index, strategy) in strategies.indexed) {
        logger.d('Executing strategy ${index + 1}/${strategies.length}');

        // Give each strategy the full timeout
        await _executeWaitStrategy(strategy).timeout(
          timeout,
          onTimeout: () {
            throw TimeoutException('Strategy ${index + 1} timed out', timeout);
          },
        );

        completed++;
        logger.d('Strategy ${index + 1} completed');
      }

      stopwatch.stop();
      logger.d(
        'All $completed strategies completed after ${stopwatch.elapsed.inSeconds}s',
      );
    } on TimeoutException catch (e) {
      stopwatch.stop();
      logger.w(
        'Strategy failed: ${e.message} after ${stopwatch.elapsed.inSeconds}s',
      );
      rethrow;
    } catch (e) {
      stopwatch.stop();
      logger.w('Error in waitForAll: $e');
      rethrow;
    }
  }
}
