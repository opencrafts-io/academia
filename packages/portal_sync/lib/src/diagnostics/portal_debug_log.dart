import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Local debug diagnostics. Never pass snapshots, prompts, responses or accounts.
void portalDebugLog(
  String stage, {
  String? model,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!kDebugMode) return;
  final message = switch (error) {
    FirebaseAIException() => error.message,
    FirebaseAISdkException() => error.message,
    FirebaseException() =>
      '${error.plugin}/${error.code}: ${error.message ?? ''}',
    PlatformException() => '${error.code}: ${error.message ?? ''}',
    FormatException() =>
      error.message, // Exclude source, which may be model JSON.
    TimeoutException() =>
      'Request timed out after ${error.duration?.inSeconds}s.',
    null => '',
    _ => 'Exception details omitted to protect portal data.',
  };
  debugPrint(
    '[portal_sync] $stage'
    '${model == null ? '' : ' model=$model'}'
    '${error == null ? '' : ' error=${error.runtimeType}: ${_redact(message)}'}',
  );
  if (stackTrace != null) {
    debugPrint(
      '[portal_sync] stack:\n${stackTrace.toString().split('\n').take(8).join('\n')}',
    );
  }
}

String _redact(String message) {
  var safe = message
      .replaceAll(RegExp(r'\{[\s\S]*\}'), '[payload omitted]')
      .replaceAll(RegExp(r'https?://[^\s]+'), '[URL omitted]')
      .replaceAll(RegExp(r'AIza[\w-]+'), '[API key omitted]')
      .replaceAll(
        RegExp(r'Bearer\s+\S+', caseSensitive: false),
        'Bearer [omitted]',
      )
      .replaceAll(
        RegExp(
          r'''\b(api[_ -]?key|token|password|cookie|authorization)\s*[:=]\s*[^\s;,]+''',
          caseSensitive: false,
        ),
        '[credential omitted]',
      )
      .replaceAll(RegExp(r'"[^"\n]*"'), '[quoted value omitted]')
      .replaceAll(RegExp(r"'[^'\n]*'"), '[quoted value omitted]')
      .replaceAll(RegExp(r'[\r\n]+'), ' ');
  if (safe.length > 1000) safe = '${safe.substring(0, 1000)}…';
  return safe;
}
