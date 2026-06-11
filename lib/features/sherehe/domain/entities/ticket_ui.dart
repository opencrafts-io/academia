import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:flutter/material.dart';

class TicketUI {
  final Ticket ticket;
  final List<Institution> institutions;
  final TicketGroupTypes? selectedTicketGroupType;
  final ScopeTypes? selectedScopeType;
  final DateTimeRange? selectedTicketDateRange;

  TicketUI({
    required this.ticket,
    required this.institutions,
    required this.selectedTicketGroupType,
    required this.selectedScopeType,
    required this.selectedTicketDateRange,
  });

  TicketUI copyWith({
    Ticket? ticket,
    List<Institution>? institutions,
    TicketGroupTypes? selectedTicketGroupType,
    ScopeTypes? selectedScopeType,
    DateTimeRange? selectedTicketDateRange,
  }) {
    return TicketUI(
      ticket: ticket ?? this.ticket,
      institutions: institutions ?? this.institutions,
      selectedTicketGroupType:
          selectedTicketGroupType ?? this.selectedTicketGroupType,
      selectedScopeType: selectedScopeType ?? this.selectedScopeType,
      selectedTicketDateRange:
          selectedTicketDateRange ?? this.selectedTicketDateRange,
    );
  }
}
