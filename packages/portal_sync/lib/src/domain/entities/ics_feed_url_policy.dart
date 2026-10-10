/// Hard, on-device SSRF guardrails for a student-supplied calendar feed URL.
///
/// A calendar feed URL is attacker-reachable input: the student may paste a
/// URL copied from somewhere untrusted, and the portal-sync design doc
/// treats this fetch exactly like a backend SSRF surface even though it
/// runs on-device. [validate] is applied to the initial URL and again to
/// every redirect hop before it is followed.
class IcsFeedUrlPolicy {
  const IcsFeedUrlPolicy._();

  /// Schemes this device will ever request. HTTP is rejected outright: a
  /// feed URL is credential-like, and a plaintext fetch would expose it.
  static const Set<String> allowedSchemes = {'https'};

  /// Returns [url] when it passes every guardrail, or throws
  /// [IcsFeedUrlRejection] describing which one failed. Never logs or
  /// includes the URL itself in the thrown error — only the reason code.
  static Uri validate(Uri url) {
    if (!allowedSchemes.contains(url.scheme.toLowerCase())) {
      throw const IcsFeedUrlRejection('scheme_not_allowed');
    }
    if (url.userInfo.isNotEmpty) {
      throw const IcsFeedUrlRejection('user_info_not_allowed');
    }
    final host = url.host.trim();
    if (host.isEmpty) {
      throw const IcsFeedUrlRejection('host_missing');
    }
    if (_isBlockedHost(host)) {
      throw const IcsFeedUrlRejection('host_not_allowed');
    }
    return url;
  }

  static bool _isBlockedHost(String host) {
    final lower = host.toLowerCase();
    if (lower == 'localhost' || lower.endsWith('.localhost')) return true;
    if (lower == '0.0.0.0' || lower == '::1' || lower == '[::1]') return true;
    final ipv4 = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');
    if (ipv4.hasMatch(lower)) {
      final parts = lower.split('.').map(int.parse).toList();
      if (parts.any((part) => part > 255)) return true;
      final a = parts[0];
      final b = parts[1];
      if (a == 127) return true; // loopback
      if (a == 10) return true; // private
      if (a == 172 && b >= 16 && b <= 31) return true; // private
      if (a == 192 && b == 168) return true; // private
      if (a == 169 && b == 254) return true; // link-local / cloud metadata
      if (a == 0) return true; // "current network"
      if (a >= 224) return true; // multicast/reserved
      return false;
    }
    // Bracketed/raw IPv6 literals: block loopback, link-local, and unique
    // local (fc00::/7) ranges by literal prefix. This is a best-effort,
    // string-level check; it does not resolve DNS to catch a hostname that
    // only later resolves to a private address.
    final ipv6 = lower.replaceAll('[', '').replaceAll(']', '');
    if (ipv6.contains(':')) {
      if (ipv6 == '::1' ||
          ipv6.startsWith('fe80:') ||
          ipv6.startsWith('fc') ||
          ipv6.startsWith('fd')) {
        return true;
      }
    }
    return false;
  }
}

/// Thrown when a feed URL (or a redirect target) fails [IcsFeedUrlPolicy].
/// Carries only a stable reason code — never the rejected URL — so it is
/// always safe to log or report.
class IcsFeedUrlRejection implements Exception {
  const IcsFeedUrlRejection(this.reasonCode);
  final String reasonCode;

  @override
  String toString() => 'IcsFeedUrlRejection($reasonCode)';
}
