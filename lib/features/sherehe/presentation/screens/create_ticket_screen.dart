import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTicketScreen extends StatefulWidget {
  final String eventId;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;

  const CreateTicketScreen({
    super.key,
    required this.eventId,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
  });

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ticketNameController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _ticketQtyController = TextEditingController();
  TicketGroupTypes? _selectedTicketGroupType;
  ScopeTypes? _selectedScopeType;
  Set<Institution> _selectedInstitutions = {};
  DateTimeRange? _selectedTicketDateRange;
  bool get isMultiDayEvent =>
      widget.eventEndDateTime.difference(widget.eventStartDateTime) >
      const Duration(hours: 24);

  @override
  void initState() {
    super.initState();

    _resetDateRange();
  }

  void _resetDateRange() {
    if (!isMultiDayEvent) return;
    _selectedTicketDateRange = DateTimeRange(
      start: widget.eventStartDateTime,
      end: widget.eventEndDateTime,
    );
  }

  void _setDateRange(DateTimeRange? newRange) {
    if (newRange == null) return;

    final start = newRange.start.isBefore(widget.eventStartDateTime)
        ? widget.eventStartDateTime
        : newRange.start;

    final end = newRange.end.isAfter(widget.eventEndDateTime)
        ? widget.eventEndDateTime
        : newRange.end;

    setState(() {
      _selectedTicketDateRange = DateTimeRange(start: start, end: end);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TicketStatsBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<TicketStatsBloc, TicketStatsState>(
            listener: (context, state) {
              if (state is AddTicketSuccess) {
                context.pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Ticket Added successfully"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              } else if (state is AddTicketError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    pinned: true,
                    title: const Text("Create Ticket"),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 20,
                          children: [
                            TextFormField(
                              controller: _ticketNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                labelText: 'Ticket Name',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter ticket name',
                              ),

                              validator: (v) => v == null || v.isEmpty
                                  ? "Please enter ticket name"
                                  : null,
                            ),
                            TextFormField(
                              controller: _ticketPriceController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                labelText: 'Ticket Price',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter ticket price',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                final num? parsed = num.tryParse(value ?? "");
                                if (parsed == null) {
                                  return "Please enter Ticket Price";
                                }
                                if (parsed <= 0) {
                                  return "Please enter a valid Ticket Price";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _ticketQtyController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                labelText: 'Ticket Quantity',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter ticket quantity',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                final int? parsed = int.tryParse(value ?? "");
                                if (parsed == null) {
                                  return "Please enter Ticket Quantity";
                                }
                                if (parsed <= 0) {
                                  return "Ticket Quantity must be at least 1";
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField(
                              initialValue: _selectedTicketGroupType,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                labelText: "Ticket Type",
                                hintText: "Select ticket type",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              items: TicketGroupTypes.values.map((type) {
                                return DropdownMenuItem<TicketGroupTypes>(
                                  value: type,
                                  child: Text(type.label),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedTicketGroupType = val;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please Select ticket type";
                                }
                                return null;
                              },
                            ),
                            TicketVisibilitySelector(
                              selectedScopeType: _selectedScopeType,
                              selectedInstitutions: _selectedInstitutions
                                  .toList(),
                              onScopeChanged: (value) {
                                setState(() {
                                  _selectedScopeType = value;
                                  if (value != ScopeTypes.institution) {
                                    _selectedInstitutions.clear();
                                  }
                                });
                              },
                              onInstitutionsChanged: (institutions) {
                                setState(() {
                                  if (institutions != null) {
                                    _selectedInstitutions = institutions
                                        .toSet();
                                  }
                                });
                              },
                            ),
                            if (isMultiDayEvent)
                              TicketDateRangeWidget(
                                selectedTicketDateRange:
                                    _selectedTicketDateRange,
                                eventStartDateTime: widget.eventStartDateTime,
                                eventEndDateTime: widget.eventEndDateTime,
                                onDateRangeChanged: _setDateRange,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => context.pop(),
                              child: const Text("Cancel"),
                            ),
                          ),

                          Expanded(
                            child: BlocBuilder<TicketStatsBloc, TicketStatsState>(
                              builder: (context, state) {
                                final isLoading = state is AddTicketLoading;

                                return FilledButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_selectedScopeType ==
                                                  ScopeTypes.institution &&
                                              _selectedInstitutions.isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Select at least one institution for restricted tickets",
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          if (_selectedTicketDateRange ==
                                                  null &&
                                              isMultiDayEvent) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Please Select valid date range for the ticket",
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<TicketStatsBloc>().add(
                                              CreateTicket(
                                                eventId: widget.eventId,
                                                ticketName:
                                                    _ticketNameController.text
                                                        .trim(),
                                                ticketPrice:
                                                    int.tryParse(
                                                      _ticketPriceController
                                                          .text
                                                          .trim(),
                                                    ) ??
                                                    0,
                                                ticketQuantity:
                                                    int.tryParse(
                                                      _ticketQtyController.text
                                                          .trim(),
                                                    ) ??
                                                    0,
                                                ticketFor:
                                                    _selectedTicketGroupType
                                                        ?.toBackend ??
                                                    0,
                                                scope:
                                                    _selectedScopeType
                                                        ?.toBackend ??
                                                    '',
                                                institutions:
                                                    _selectedScopeType !=
                                                        ScopeTypes.institution
                                                    ? null
                                                    : _selectedInstitutions
                                                          .map(
                                                            (e) =>
                                                                e.institutionId,
                                                          )
                                                          .toList(),
                                                startDate:
                                                    _selectedTicketDateRange
                                                        ?.start
                                                        .toUtc()
                                                        .toIso8601String() ??
                                                    widget.eventStartDateTime
                                                        .toUtc()
                                                        .toIso8601String(),
                                                endDate:
                                                    _selectedTicketDateRange
                                                        ?.end
                                                        .toUtc()
                                                        .toIso8601String() ??
                                                    widget.eventEndDateTime
                                                        .toUtc()
                                                        .toIso8601String(),
                                              ),
                                            );
                                          }
                                        },
                                  child: isLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        )
                                      : const Text("Create"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _ticketNameController.dispose();
    _ticketPriceController.dispose();
    _ticketQtyController.dispose();
    super.dispose();
  }
}
