import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class EditStudentProfilePage extends StatefulWidget {
  final int profileId;

  const EditStudentProfilePage({super.key, required this.profileId});

  @override
  State<EditStudentProfilePage> createState() => _EditStudentProfilePageState();
}

class _EditStudentProfilePageState extends State<EditStudentProfilePage> {
  final _formKey = GlobalKey<FormState>();
  InstitutionProfile? _draftProfile;

  @override
  void initState() {
    super.initState();
    context.read<StudentProfileBloc>().add(
      WatchProfileByIdEvent(profileId: widget.profileId),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate() && _draftProfile != null) {
      if (!_formKey.currentState!.validate()) return;

      if (_draftProfile == null) return;

      if (_draftProfile!.enrollmentDate != null &&
          _draftProfile!.expectedGraduation != null) {
        if (_draftProfile!.expectedGraduation!.isBefore(
          _draftProfile!.enrollmentDate!,
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Graduation date cannot be before enrollment date",
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
      }

      context.read<StudentProfileBloc>().add(
        UpdateProfileEvent(
          profileId: widget.profileId,
          profile: _draftProfile!,
        ),
      );
    }
  }

  void _autoGuessYear(DateTime enrollmentDate) {
    final now = DateTime.now();

    int yearsDiff = now.year - enrollmentDate.year;

    if (now.month < enrollmentDate.month) {
      yearsDiff--;
    }

    final guessedYear = (yearsDiff + 1).clamp(1, 7);

    setState(() {
      _draftProfile = _draftProfile?.copyWith(year: guessedYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<StudentProfileBloc, StudentProfileState>(
      listener: (context, state) {
        if (state.status == StudentProfileStatus.success &&
            _draftProfile == null) {
          setState(() {
            _draftProfile = state.profile;
          });
          if (ModalRoute.of(context)?.isCurrent == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Profile updated successfully"),
              ),
            );
          }
        }

        if (state.status == StudentProfileStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "An error occurred"),
              backgroundColor: theme.colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == StudentProfileStatus.loading) {
          return const Scaffold(body: Center(child: LoadingIndicatorM3E()));
        }

        return Scaffold(
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: const Text("View & Edit Profile"),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilledButton.icon(
                        onPressed: _draftProfile != null ? _onSave : null,
                        icon: const Icon(Icons.check_circle_outline_rounded),
                        label: const Text("Save"),
                      ),
                    ),
                  ],
                ),

                if (_draftProfile != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        _draftProfile!.studentId,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                // 3. Form Fields
                if (_draftProfile != null)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _SectionHeader(title: "Identity"),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _draftProfile?.studentName,
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          onChanged: (v) => _draftProfile = _draftProfile!
                              .copyWith(studentName: v),
                        ),
                        const SizedBox(height: 16),
                        _GenderSelector(
                          current: _draftProfile!.gender ?? Gender.unknown,
                          onChanged: (g) => setState(
                            () => _draftProfile = _draftProfile!.copyWith(
                              gender: g,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _draftProfile?.major,
                          decoration: const InputDecoration(
                            labelText: "Major",
                            prefixIcon: Icon(Icons.book_outlined),
                          ),
                          onChanged: (v) => _draftProfile = _draftProfile!
                              .copyWith(major: v, program: v),
                        ),

                        const SizedBox(height: 32),

                        _SectionHeader(title: "Academics"),
                        const SizedBox(height: 16),
                        _StatusSegmentedButton(
                          current:
                              _draftProfile!.status ?? AcademicStatus.unknown,
                          onChanged: (s) => setState(
                            () => _draftProfile = _draftProfile!.copyWith(
                              status: s,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _DatePickerField(
                                label: "Enrollment",
                                date: _draftProfile!.enrollmentDate,
                                onChanged: (d) {
                                  setState(
                                    () => _draftProfile = _draftProfile!
                                        .copyWith(enrollmentDate: d),
                                  );
                                  _autoGuessYear(d);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DatePickerField(
                                label: "Graduation",
                                date: _draftProfile!.expectedGraduation,
                                onChanged: (d) => setState(
                                  () => _draftProfile = _draftProfile!.copyWith(
                                    expectedGraduation: d,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        _SectionHeader(title: "Contact"),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _draftProfile?.phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          onChanged: (v) =>
                              _draftProfile = _draftProfile!.copyWith(phone: v),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _draftProfile?.email,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                          onChanged: (v) =>
                              _draftProfile = _draftProfile!.copyWith(email: v),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          initialValue: _draftProfile?.address,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Residential Address",
                            prefixIcon: Icon(Icons.map_outlined),
                          ),
                          onChanged: (v) => _draftProfile = _draftProfile!
                              .copyWith(address: v),
                        ),
                        const SizedBox(height: 100),
                      ]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final Gender current;
  final ValueChanged<Gender> onChanged;

  const _GenderSelector({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      initialValue: current,
      decoration: const InputDecoration(
        labelText: "Gender",
        prefixIcon: Icon(Icons.people_outline_rounded),
      ),
      items: Gender.values.map((g) {
        return DropdownMenuItem(
          value: g,
          child: Text(
            g.name
                .split('_')
                .map((e) => e[0].toUpperCase() + e.substring(1))
                .join(' '),
          ),
        );
      }).toList(),
      onChanged: (v) => v != null ? onChanged(v) : null,
    );
  }
}

class _StatusSegmentedButton extends StatelessWidget {
  final AcademicStatus current;
  final ValueChanged<AcademicStatus> onChanged;

  const _StatusSegmentedButton({
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AcademicStatus>(
      segments: const [
        ButtonSegment(value: AcademicStatus.active, label: Text("Active")),
        ButtonSegment(value: AcademicStatus.suspended, label: Text("Hold")),
        ButtonSegment(value: AcademicStatus.completed, label: Text("Done")),
      ],
      selected: {current},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onChanged;

  const _DatePickerField({
    required this.label,
    this.date,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2030),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today_rounded),
        ),
        child: Text(
          date != null ? DateFormat('MMM dd, yyyy').format(date!) : "Select",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
