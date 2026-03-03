import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

class TicketUI {
  final Ticket ticket;
  final bool isPublic;
  final List<Institution> institutions;

  TicketUI({
    required this.ticket,
    required this.isPublic,
    required this.institutions,
  });

  TicketUI copyWith({
    Ticket? ticket,
    bool? isPublic,
    List<Institution>? institutions,
  }) {
    return TicketUI(
      ticket: ticket ?? this.ticket,
      isPublic: isPublic ?? this.isPublic,
      institutions: institutions ?? this.institutions,
    );
  }
}
