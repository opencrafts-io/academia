import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';

class TicketUI {
  final Ticket ticket;
  final bool isPublic;
  final List<Institution> institutions;
  final TicketGroupTypes? selectedTicketGroupType; //placeholder for now

  TicketUI({
    required this.ticket,
    required this.isPublic,
    required this.institutions,
    required this.selectedTicketGroupType,
  });

  TicketUI copyWith({
    Ticket? ticket,
    bool? isPublic,
    List<Institution>? institutions,
    TicketGroupTypes? selectedTicketGroupType,
  }) {
    return TicketUI(
      ticket: ticket ?? this.ticket,
      isPublic: isPublic ?? this.isPublic,
      institutions: institutions ?? this.institutions,
      selectedTicketGroupType:
          selectedTicketGroupType ?? this.selectedTicketGroupType,
    );
  }
}
