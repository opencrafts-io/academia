import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_tip.freezed.dart';
part 'splash_tip.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SplashTipAction { premium, notifications, lockIn }

@freezed
abstract class SplashTip with _$SplashTip {
  const SplashTip._();

  const factory SplashTip({
    required String id,
    required String title,
    required String message,
    @Default('') String actionLabel,
    SplashTipAction? action,
  }) = _SplashTip;

  factory SplashTip.fromJson(Map<String, dynamic> json) =>
      _$SplashTipFromJson(json);

  IconData get icon => switch (action) {
    SplashTipAction.premium => Icons.workspace_premium_outlined,
    SplashTipAction.notifications => Icons.notifications_active_outlined,
    SplashTipAction.lockIn => Icons.hourglass_top_rounded,
    null => Icons.lightbulb_outline_rounded,
  };
}

@freezed
abstract class SplashTipConfiguration with _$SplashTipConfiguration {
  const SplashTipConfiguration._();

  const factory SplashTipConfiguration({
    @Default(true) bool enabled,
    @JsonKey(name: 'minimumDisplayMs') @Default(2200) int minimumDisplayMs,
    @Default(<SplashTip>[]) List<SplashTip> tips,
  }) = _SplashTipConfiguration;

  static const flagKey = 'splash_launch_tips';
  static const _maximumDisplayMs = 5000;

  static const defaults = SplashTipConfiguration(
    enabled: true,
    minimumDisplayMs: 2200,
    tips: [
      SplashTip(
        id: 'premium',
        title: 'Want fewer interruptions?',
        message:
            'Premium removes ads across Academia and supports your study flow.',
        actionLabel: 'Explore Premium',
        action: SplashTipAction.premium,
      ),
      SplashTip(
        id: 'notifications',
        title: 'Make reminders work for you',
        message: 'Choose which study and course reminders you want to receive.',
        actionLabel: 'Notification settings',
        action: SplashTipAction.notifications,
      ),
      SplashTip(
        id: 'lock-in',
        title: 'Give your focus some space',
        message: 'Lock In can block distracting apps during the study time you choose.',
        actionLabel: 'Explore Lock In',
        action: SplashTipAction.lockIn,
      ),
    ],
  );

  factory SplashTipConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SplashTipConfigurationFromJson(json);

  Duration get minimumDisplayDuration =>
      Duration(milliseconds: minimumDisplayMs);

  static SplashTipConfiguration? tryParse(Object? payload) {
    try {
      final decoded = payload is String ? jsonDecode(payload) : payload;
      if (decoded is! Map) return null;

      final configuration = SplashTipConfiguration.fromJson(
        Map<String, dynamic>.from(decoded),
      );
      if (configuration.enabled && configuration.tips.isEmpty) return null;

      return configuration.copyWith(
        minimumDisplayMs: configuration.enabled
            ? configuration.minimumDisplayMs.clamp(0, _maximumDisplayMs).toInt()
            : 0,
      );
    } on Object {
      return null;
    }
  }
}
