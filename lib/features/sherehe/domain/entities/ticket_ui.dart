import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';

class TicketUI {
  final Ticket ticket;
  final List<Institution> institutions;
  final TicketGroupTypes? selectedTicketGroupType; //placeholder for now
  final ScopeTypes? selectedScopeType; //placeholder for now

  TicketUI({
    required this.ticket,
    required this.institutions,
    required this.selectedTicketGroupType,
    required this.selectedScopeType,
  });

  TicketUI copyWith({
    Ticket? ticket,
    List<Institution>? institutions,
    TicketGroupTypes? selectedTicketGroupType,
    ScopeTypes? selectedScopeType,
  }) {
    return TicketUI(
      ticket: ticket ?? this.ticket,
      institutions: institutions ?? this.institutions,
      selectedTicketGroupType:
          selectedTicketGroupType ?? this.selectedTicketGroupType,
      selectedScopeType: selectedScopeType ?? this.selectedScopeType,
    );
  }
}
