import 'package:academia/features/semester/semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:intl/intl.dart';

class EditSemesterSheet extends StatefulWidget {
  final int semesterId;
  const EditSemesterSheet({super.key, required this.semesterId});

  @override
  State<EditSemesterSheet> createState() => _EditSemesterSheetState();
}

class _EditSemesterSheetState extends State<EditSemesterSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _loadSemester();
  }

  Future<void> _loadSemester() async {
    final semester = await context.read<SemesterCubit>().getSemesterById(
      widget.semesterId,
    );
    if (semester != null && mounted) {
      setState(() {
        _nameController.text = semester.name;
        _descController.text = semester.description ?? '';
        _startDate = semester.startDate;
        _endDate = semester.endDate;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return SheetContentScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update Semester",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),

                // Standard M3 TextField
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Semester Name",
                    prefixIcon: Icon(Icons.edit_calendar),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                // Date Selectors (using the _DateTile from previous response)
                Row(
                  children: [
                    Expanded(
                      child: _DateTile(
                        label: "Start",
                        date: _startDate,
                        onTap: () => _pickDate(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DateTile(
                        label: "End",
                        date: _endDate,
                        onTap: () => _pickDate(false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _update,
                    child: const Text("Save Changes"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _update() {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null) {
      final updated = SemesterEntity(
        id: widget.semesterId,
        name: _nameController.text,
        description: _descController.text,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      context.read<SemesterCubit>().updateSemester(updated);
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => isStart ? _startDate = picked : _endDate = picked);
    }
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateTile({required this.label, this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(
              date != null ? dateFormat.format(date!) : "Select Date",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: date == null
                    ? Theme.of(context).colorScheme.secondary
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
