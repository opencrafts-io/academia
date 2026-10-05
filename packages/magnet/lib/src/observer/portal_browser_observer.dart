import 'dart:async';
import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'portal_snapshot_sanitizer.dart';

/// Read-only observation of visible, non-form content in an approved portal.
///
/// This class never clicks, fills, or submits page controls. Its JavaScript is
/// fixed package code; page data is passed through a bounded schema only.
class PortalBrowserObserver {
  PortalBrowserObserver({
    required this.controller,
    required Set<String> allowedOrigins,
    required this.onSnapshot,
    this.onHint,
  }) : allowedOrigins = _validatedOrigins(allowedOrigins);

  final InAppWebViewController controller;
  final Set<String> allowedOrigins;
  final void Function(Map<String, dynamic>) onSnapshot;

  /// A capture notice, or null when a previously partial capture is complete.
  final void Function(String?)? onHint;

  static const String _handlerName = 'magnetPortalSnapshot';
  static const Duration _pollInterval = Duration(milliseconds: 900);

  Timer? _pollTimer;
  String? _lastSnapshot;
  bool _started = false;
  bool _paused = false;
  bool _disposed = false;
  bool _truncationHintActive = false;

  /// Begins observation and reinstalls the fixed observer after full navigations.
  Future<void> start() async {
    if (_disposed) return;
    if (!_started) {
      _started = true;
      try {
        controller.addJavaScriptHandler(
          handlerName: _handlerName,
          callback: _handlePageMessage,
        );
      } catch (_) {
        _started = false;
        return;
      }
    }
    _paused = false;
    await _installForCurrentPage();
    _pollTimer ??= Timer.periodic(
      _pollInterval,
      (_) => _installForCurrentPage(),
    );
  }

  /// Captures the current settled page, returning null when it is not approved.
  Future<Map<String, dynamic>?> capture() async {
    if (!_started || _paused || _disposed) return null;
    final page = await _currentPage();
    if (page == null || !_isAllowed(page.origin)) return null;
    await _ensureInstalled();
    if (!_started || _paused || _disposed) return null;
    dynamic raw;
    try {
      raw = await controller.evaluateJavascript(source: _captureScript);
    } catch (_) {
      return null;
    }
    if (!_started || _paused || _disposed) return null;
    final decoded = _decode(raw);
    final envelope = decoded is Map ? decoded : const <String, dynamic>{};
    final rawSnapshot = envelope.containsKey('snapshot')
        ? envelope['snapshot']
        : decoded;
    final snapshot = PortalSnapshotSanitizer.sanitize(
      rawSnapshot,
      expectedOrigin: page.origin,
    );
    if (snapshot == null) return null;
    _updateTruncationHint(
      envelope['truncated'] == true ||
          PortalSnapshotSanitizer.hasTrimmedTableRows(rawSnapshot, snapshot),
    );
    _deliver(snapshot);
    return snapshot;
  }

  void pause() {
    if (_disposed) return;
    _paused = true;
    _lastSnapshot = null;
  }

  Future<void> resume() async {
    if (_disposed || !_started) return;
    _paused = false;
    _lastSnapshot = null;
    await _installForCurrentPage();
  }

  void stop() {
    if (_disposed) return;
    _started = false;
    _paused = false;
    _pollTimer?.cancel();
    _pollTimer = null;
    _lastSnapshot = null;
    try {
      controller.removeJavaScriptHandler(handlerName: _handlerName);
    } catch (_) {
      // Native WebView teardown can race with handler removal.
    }
  }

  /// Adds a brief outline to an existing observed node. No page action occurs.
  Future<void> highlight(String nodeId) async {
    if (!_started ||
        _paused ||
        _disposed ||
        !RegExp(r'^n\d{1,3}$').hasMatch(nodeId)) {
      return;
    }
    final page = await _currentPage();
    if (page == null || !_isAllowed(page.origin)) return;
    final argument = jsonEncode(nodeId);
    try {
      await controller.evaluateJavascript(
        source:
            '''(() => {
      const node = Array.from(document.querySelectorAll('[data-magnet-node-id]')).find(el => el.dataset.magnetNodeId === $argument);
      if (!node || !node.isConnected) return false;
      const oldOutline = node.style.outline;
      const oldOffset = node.style.outlineOffset;
      node.style.outline = '3px solid #2f80ed';
      node.style.outlineOffset = '2px';
      window.setTimeout(() => {
        if (node.isConnected) { node.style.outline = oldOutline; node.style.outlineOffset = oldOffset; }
      }, 2200);
      return true;
    })()''',
      );
    } catch (_) {
      // The WebView may be disposed between the URL check and evaluation.
    }
  }

  void dispose() {
    if (_disposed) return;
    stop();
    _disposed = true;
  }

  dynamic _handlePageMessage(JavaScriptHandlerFunctionData data) {
    if (!_started || _paused || _disposed || !data.isMainFrame) return null;
    final sourceOrigin = _origin(data.origin.toString());
    final requestOrigin = _origin(data.requestUrl.origin);
    if (sourceOrigin == null ||
        sourceOrigin != requestOrigin ||
        !_isAllowed(sourceOrigin)) {
      return null;
    }
    if (data.args.isEmpty) return null;
    final rawSnapshot = data.args.first;
    final snapshot = PortalSnapshotSanitizer.sanitize(
      rawSnapshot,
      expectedOrigin: sourceOrigin,
    );
    if (snapshot != null) {
      _updateTruncationHint(
        (data.args.length > 1 && data.args[1] == true) ||
            PortalSnapshotSanitizer.hasTrimmedTableRows(rawSnapshot, snapshot),
      );
      _deliver(snapshot);
    }
    return null;
  }

  Future<void> _installForCurrentPage() async {
    if (!_started || _paused || _disposed) return;
    final page = await _currentPage();
    if (page == null || !_isAllowed(page.origin)) {
      return;
    }
    await _ensureInstalled();
  }

  Future<void> _ensureInstalled() async {
    if (!_started || _paused || _disposed) return;
    // Re-run the fixed bootstrap on every poll so identical-URL full document
    // navigations reinstall observation after their JavaScript context resets.
    try {
      await controller.evaluateJavascript(source: _observerScript);
    } catch (_) {
      // Ignore transient navigation and disposal races; the next load or poll retries.
    }
  }

  Future<_PageLocation?> _currentPage() async {
    try {
      final uri = Uri.parse((await controller.getUrl())?.toString() ?? '');
      final origin = _origin(uri.origin);
      if (origin == null || uri.scheme != 'https') return null;
      return _PageLocation(origin);
    } catch (_) {
      return null;
    }
  }

  bool _isAllowed(String? origin) =>
      origin != null && allowedOrigins.contains(origin);

  String? _origin(String value) =>
      PortalSnapshotSanitizer.normalizeHttpsOrigin(value);

  dynamic _decode(dynamic value) {
    if (value is String) {
      try {
        return jsonDecode(value);
      } catch (_) {
        return null;
      }
    }
    return value;
  }

  void _updateTruncationHint(bool isTruncated) {
    if (isTruncated == _truncationHintActive) return;
    _truncationHintActive = isTruncated;
    onHint?.call(
      isTruncated
          ? 'Only part of this page’s tables fit in one capture. You can review and save the captured rows, then use the portal’s filters or next page to check the rest.'
          : null,
    );
  }

  void _deliver(Map<String, dynamic> snapshot) {
    if (!_started || _paused || _disposed) return;
    final encoded = jsonEncode(snapshot);
    if (encoded == _lastSnapshot) return;
    _lastSnapshot = encoded;
    onSnapshot(snapshot);
  }

  static const String _captureScript = r'''(() => {
        if (!window.__magnetPortalCapture) return null;
        const snapshot = window.__magnetPortalCapture();
        return snapshot ? {snapshot, truncated: window.__magnetPortalTruncated === true} : null;
      })()''';

  static const String _observerScript = r'''(() => {
    if (window.__magnetPortalObserver && window.__magnetPortalHref === location.href) return true;
    window.__magnetPortalCleanup?.();
    window.__magnetPortalHref = location.href;
    let sequence = 0;
    const clean = (s, limit) => (s || '').replace(/\s+/g, ' ').trim().slice(0, limit);
    const visible = (el) => {
      if (!(el instanceof Element) || !el.isConnected) return false;
      const style = getComputedStyle(el), rect = el.getBoundingClientRect();
      return style.display !== 'none' && style.visibility !== 'hidden' && Number(style.opacity) > 0 && rect.width > 0 && rect.height > 0;
    };
    const sensitive = (s) => /password|passcode|secret|token|csrf|session|student\s*(id|number|no\.?|email|name)|full\s*name|profile|account|welcome|hello|registration\s*(id|number)|matric(ulation)?\s*(id|number)|national\s*(id|identity)|email|phone|mobile/i.test(s || '');
    const safeText = (el, limit) => {
      if (!visible(el) || el.closest('form,[contenteditable="true"],[contenteditable=""]')) return '';
      const text = clean(el.innerText || el.textContent, limit);
      if (!text || sensitive(text) || /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b|\b\d{6,}\b|\b[A-Z]{1,3}[-/]?\d{5,}\b/i.test(text)) return '';
      return text;
    };
    const identify = (el) => {
      const id = 'n' + sequence++;
      el.setAttribute('data-magnet-node-id', id);
      return id;
    };
    const buildSnapshot = () => {
      sequence = 0;
      document.querySelectorAll('[data-magnet-node-id]').forEach(el => el.removeAttribute('data-magnet-node-id'));
      const headings = [], links = [], tables = [], fields = [];
      let truncated = false;
      const budgets = {heading:12, link:20, table:24, field:24};
      const buckets = {heading:headings, link:links};
      const pushTextNode = (el, kind) => {
        const label = safeText(el, 120), bucket = buckets[kind];
        if (label && bucket.length < budgets[kind]) bucket.push({id: identify(el), kind, label});
      };
      document.querySelectorAll('h1,h2,h3,h4,h5,h6').forEach(el => pushTextNode(el, 'heading'));
      document.querySelectorAll('a[href]').forEach(el => pushTextNode(el, 'link'));
      document.querySelectorAll('table').forEach(table => {
        if (!visible(table) || table.closest('form')) return;
        const rows = Array.from(table.rows).filter(visible);
        if (!rows.length) return;
        const isWideTitle = row => row.cells.length === 1 && row.cells[0].colSpan > 1;
        const isSummary = row => /^(total|subtotal|grand total|summary|end of results|showing\s+\d+)/i.test(
          clean(row.cells[0]?.innerText || row.cells[0]?.textContent, 80)
        );
        let headerRows = rows.filter(row => row.parentElement?.tagName === 'THEAD' &&
          !isWideTitle(row));
        if (!headerRows.length) {
          headerRows = [];
          for (const row of rows) {
            if (row.parentElement?.tagName === 'TFOOT' || isWideTitle(row)) continue;
            if (Array.from(row.cells).every(cell => cell.tagName === 'TH' && cell.scope !== 'row')) {
              headerRows.push(row);
            } else {
              break;
            }
          }
        }
        if (!headerRows.length) return;
        const headerWidth = Math.max(...headerRows.map(row =>
          Array.from(row.cells).reduce((width, cell) => width + Math.max(1, cell.colSpan), 0)
        ));
        if (headerWidth < 1 || headerWidth > 16) return;
        const headerGrid = Array.from({length: headerRows.length}, () => Array(headerWidth).fill(''));
        const occupiedUntil = Array(headerWidth).fill(-1);
        const identifier = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b|\b\d{6,}\b|\b[A-Z]{1,3}[-/]?\d{5,}\b/i;
        const personalHeader = value => sensitive(value) || identifier.test(value) || /^(name|first\s*name|last\s*name|full\s*name)$/i.test(value);
        let invalidHeaders = false;
        headerRows.forEach((row, rowIndex) => {
          let column = 0;
          for (const cell of Array.from(row.cells)) {
            while (column < headerWidth && occupiedUntil[column] >= rowIndex) column++;
            const columnSpan = Math.max(1, cell.colSpan);
            const rowSpan = Math.max(1, cell.rowSpan);
            const rawLabel = clean(cell.innerText || cell.textContent, 180);
            if (!rawLabel || personalHeader(rawLabel) || column + columnSpan > headerWidth) {
              invalidHeaders = true;
              break;
            }
            const label = safeText(cell, 180);
            if (!label) { invalidHeaders = true; break; }
            for (let offset = 0; offset < columnSpan; offset++) {
              const targetColumn = column + offset;
              for (let targetRow = rowIndex; targetRow < Math.min(headerRows.length, rowIndex + rowSpan); targetRow++) {
                headerGrid[targetRow][targetColumn] = label;
              }
              occupiedUntil[targetColumn] = rowIndex + rowSpan - 1;
            }
            column += columnSpan;
          }
        });
        if (invalidHeaders) return;
        const headers = Array.from({length: headerWidth}, (_, column) =>
          Array.from(new Set(headerGrid.map(row => row[column]).filter(Boolean))).join(' / ')
        );
        if (headers.some(header => !header || personalHeader(header))) return;
        const headerSet = new Set(headerRows);
        const bodyRows = rows.filter(row => {
          if (headerSet.has(row) || row.parentElement?.tagName === 'THEAD' ||
              row.parentElement?.tagName === 'TFOOT' || isWideTitle(row) || isSummary(row)) return false;
          const cells = Array.from(row.cells);
          if (cells.some(cell => cell.colSpan !== 1 || cell.rowSpan !== 1)) return false;
          if (cells.some(cell => cell.tagName === 'TH' && cell.scope !== 'row')) return false;
          if (cells.length !== headerWidth) return false;
          return true;
        });
        if (tables.length >= budgets.table) {
          if (bodyRows.length) truncated = true;
          return;
        }
        const values = [];
        for (const row of bodyRows) {
          if (values.length >= 60) { truncated = true; break; }
          values.push(Array.from(row.cells).map(cell => {
            const value = safeText(cell, 180);
            return identifier.test(value) ? '' : value;
          }));
        }
        const label = safeText(table.caption, 120) || headers.slice(0, 3).join(' / ') || 'Table';
        tables.push({id: identify(table), kind: 'table', label, headers, rows: values});
      });
      document.querySelectorAll('dl').forEach(list => {
        if (!visible(list) || list.closest('form')) return;
        Array.from(list.querySelectorAll('dt')).forEach(term => {
          if (fields.length >= budgets.field) return;
          const label = safeText(term, 120), valueEl = term.nextElementSibling;
          const value = valueEl && valueEl.matches('dd') ? safeText(valueEl, 180) : '';
          if (label && value && !sensitive(label)) fields.push({id: identify(valueEl), kind: 'field', label, value});
        });
      });
      const path = location.pathname;
      if (document.querySelector('input[type="password"]') || /\/(login|log-in|signin|sign-in|oauth|authorize|authentication)(\/|$)/i.test(path)) return null;
      window.__magnetPortalTruncated = truncated;
      return {origin:location.origin, path, title:clean(document.title,160), language:clean(document.documentElement.lang,24)||'und', nodes:[...headings,...links,...tables,...fields]};
    };
    window.__magnetPortalCapture = buildSnapshot;
    let timer;
    const schedule = () => {
      clearTimeout(timer);
      timer = setTimeout(() => {
        const snapshot = buildSnapshot();
        if (snapshot && window.flutter_inappwebview?.callHandler) window.flutter_inappwebview.callHandler('magnetPortalSnapshot', snapshot, window.__magnetPortalTruncated === true);
      }, 650);
    };
    const observer = new MutationObserver(schedule);
    observer.observe(document.documentElement, {subtree:true, childList:true, characterData:true});
    window.__magnetPortalObserver = observer;
    window.__magnetPortalCleanup = () => { clearTimeout(timer); observer.disconnect(); };
    window.__magnetPortalSchedule = schedule;
    if (!window.__magnetPortalNavigationListeners) {
      window.__magnetPortalNavigationListeners = true;
      window.addEventListener('popstate', () => window.__magnetPortalSchedule?.());
      window.addEventListener('hashchange', () => window.__magnetPortalSchedule?.());
      for (const method of ['pushState', 'replaceState']) {
        const original = history[method];
        history[method] = function(...args) {
          const result = original.apply(this, args);
          window.__magnetPortalSchedule?.();
          return result;
        };
      }
    }
    schedule();
    return true;
  })()''';

  static Set<String> _validatedOrigins(Set<String> origins) {
    final normalized = <String>{};
    for (final origin in origins) {
      final value = PortalSnapshotSanitizer.normalizeHttpsOrigin(origin);
      if (value == null) {
        throw ArgumentError.value(
          origin,
          'allowedOrigins',
          'Must contain HTTPS origins only.',
        );
      }
      normalized.add(value);
    }
    if (normalized.isEmpty) {
      throw ArgumentError.value(
        origins,
        'allowedOrigins',
        'At least one origin is required.',
      );
    }
    return normalized;
  }
}

class _PageLocation {
  const _PageLocation(this.origin);
  final String origin;
}
