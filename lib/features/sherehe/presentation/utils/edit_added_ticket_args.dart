import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket_ui.dart';

class EditAddedTicketArgs {
  final TicketUI ticket;
  final List<Institution>? eligibleInstitutions;

  const EditAddedTicketArgs({required this.ticket, this.eligibleInstitutions});
}
