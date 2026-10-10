import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'portal_analysis_plan.dart';
import 'portal_connection.dart';
import 'portal_draft_extractor.dart' show PortalCapture;
import 'portal_profile_fee_draft.dart';

/// Extracts profile fields and fee-statement line items from validated
/// captures, reusing the same `PortalSnapshot`/`PortalAnalysisPlan` model
/// and validation rules as `PortalDraftExtractor` (courses/timetable).
/// Nothing here duplicates that validation; a capture whose plan does not
/// validate for its snapshot is skipped exactly as it is there.
class PortalProfileFeeDraftExtractor {
  const PortalProfileFeeDraftExtractor();

  static final RegExp _balanceDuePattern = RegExp(
    r'\b(balance\s*due|total\s*due|amount\s*due|outstanding)\b',
    caseSensitive: false,
  );

  PortalProfileFeeDraft? extract(
    PortalConnection connection,
    Iterable<PortalCapture> captures, {
    DateTime? observedAt,
  }) {
    final fields = <String, PortalProfileFieldDraft>{};
    final lines = <String, PortalFeeLineItemDraft>{};
    final occurrenceCounts = <String, int>{};

    for (final (snapshot, plan) in captures) {
      if (!plan.validateFor(snapshot)) continue;
      final nodes = {for (final node in snapshot.nodes) node.id: node};

      for (final field in plan.fields) {
        final node = nodes[field.nodeId];
        final rawValue = node?.value?.trim();
        if (node == null || rawValue == null || rawValue.isEmpty) continue;
        final sourceId = _id([
          connection.accountId,
          connection.origin,
          connection.institutionId,
          field.fieldKey.name,
        ]);
        fields[sourceId] = PortalProfileFieldDraft(
          sourceId: sourceId,
          fieldKey: field.fieldKey.name,
          sourcePage: snapshot.path,
          rawValue: rawValue,
        );
      }

      for (final table in plan.tables.where(
        (table) => table.kind == PortalTableKind.feeLineItems,
      )) {
        final node = nodes[table.nodeId];
        if (node == null) continue;
        final columns = table.columns;
        for (final row in node.rows) {
          if (row.length != node.headers.length) continue;
          final description = _cell(row, columns.description)?.trim() ?? '';
          if (description.isEmpty) continue;
          final debit = _nonEmpty(_cell(row, columns.debit)?.trim());
          final credit = _nonEmpty(_cell(row, columns.credit)?.trim());
          final balance = _nonEmpty(_cell(row, columns.balance)?.trim());
          String kind;
          String rawAmount;
          if (debit != null) {
            kind = 'debit';
            rawAmount = debit;
          } else if (credit != null) {
            kind = 'credit';
            rawAmount = credit;
          } else if (balance != null) {
            kind = _balanceDuePattern.hasMatch(description)
                ? 'balanceDue'
                : 'runningBalance';
            rawAmount = balance;
          } else {
            continue;
          }
          final currencyText = _nonEmpty(_cell(row, columns.currency)?.trim());
          final rawDate = _nonEmpty(_cell(row, columns.date)?.trim());
          final occurrenceKey =
              '${table.nodeId}|${description.toLowerCase()}|$kind|$rawAmount';
          final occurrence = occurrenceCounts.update(
            occurrenceKey,
            (count) => count + 1,
            ifAbsent: () => 0,
          );
          final sourceId = _id([
            connection.accountId,
            connection.origin,
            connection.institutionId,
            table.nodeId,
            description.toLowerCase(),
            kind,
            occurrence,
          ]);
          lines[sourceId] = PortalFeeLineItemDraft(
            sourceId: sourceId,
            kind: kind,
            description: description,
            rawAmount: rawAmount,
            currencyText: currencyText,
            rawDate: rawDate,
            sourcePage: snapshot.path,
          );
        }
      }
    }

    if (fields.isEmpty && lines.isEmpty) return null;
    final draft = PortalProfileFeeDraft(
      profileFields: fields.values.toList(),
      feeLineItems: lines.values.toList(),
      sourceOrigin: connection.origin,
      observedAt: observedAt ?? DateTime.now().toUtc(),
    );
    return draft.isValid ? draft : null;
  }

  static String? _cell(List<String> row, int? index) =>
      index == null || index >= row.length ? null : row[index];
  static String? _nonEmpty(String? value) =>
      value == null || value.isEmpty ? null : value;

  static String _id(List<Object?> components) =>
      sha256.convert(utf8.encode(jsonEncode(components))).toString();
}
