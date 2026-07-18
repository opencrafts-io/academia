import 'package:academia/features/exam_timetable/presentation/widgets/exam_search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';

class ExamTimetableSearchScreen extends StatefulWidget {
  final int institutionId;

  const ExamTimetableSearchScreen({super.key, required this.institutionId});

  @override
  State<ExamTimetableSearchScreen> createState() =>
      _ExamTimetableSearchScreenState();
}

class _ExamTimetableSearchScreenState extends State<ExamTimetableSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedExams = {};
  List<ExamTimetable> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> _parseCourseCodes(String input) {
    return input
        .split(',')
        .map((code) => code.trim())
        .where((code) => code.isNotEmpty)
        .toList();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final courseCodes = _parseCourseCodes(query);
      if (courseCodes.isNotEmpty) {
        context.read<ExamTimetableBloc>().add(
          SearchExamTimetable(
            institutionId: widget.institutionId,
            courseCodes: courseCodes,
          ),
        );
        setState(() {
          _isSearching = true;
        });
      }
    }
  }

  void _toggleSelection(String courseCode) {
    setState(() {
      if (_selectedExams.contains(courseCode)) {
        _selectedExams.remove(courseCode);
      } else {
        _selectedExams.add(courseCode);
      }
    });
  }

  void _addToTimetable() {
    if (_selectedExams.isNotEmpty) {
      final examsToAdd = _searchResults
          .where((exam) => _selectedExams.contains(exam.courseCode))
          .toList();

      if (examsToAdd.isNotEmpty) {
        context.read<ExamTimetableBloc>().add(
          AddExamsToTimetable(
            institutionId: widget.institutionId,
            exams: examsToAdd,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${examsToAdd.length} course(s) added to timetable'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: _isSearching
                        ? _searchController.text
                        : 'BIL111K, ENG111R, MAT121K',
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  onSubmitted: (_) => _performSearch(),
                  textInputAction: TextInputAction.search,
                ),
              ),
            ],
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty && _isSearching)
            IconButton(
              icon: Icon(Icons.close_rounded, color: colorScheme.onSurface),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _isSearching = false;
                  _searchResults = [];
                  _selectedExams.clear();
                });
              },
            ),
        ],
      ),
      body: BlocConsumer<ExamTimetableBloc, ExamTimetableState>(
        listener: (context, state) {
          if (state is ExamTimetableLoaded) {
            setState(() {
              _searchResults = state.exams;
              _selectedExams.clear();
            });
          } else if (state is ExamTimetableError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ExamTimetableLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (state is ExamTimetableEmpty) {
            return _SearchInfoState(
              icon: Icons.search_off_rounded,
              title: state.message,
            );
          }

          if (!_isSearching) {
            return const _SearchInfoState(
              icon: Icons.search_rounded,
              title: 'Provide courses to search for.',
              subtitle: 'Separate multiple course codes with commas',
              hint: 'Example: BIL111K, ENG111R, MAT121K',
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final exam = _searchResults[index];
                    final isSelected = _selectedExams.contains(exam.courseCode);

                    return ExamSearchResultCard(
                      exam: exam,
                      isSelected: isSelected,
                      onTap: () => _toggleSelection(exam.courseCode),
                    );
                  },
                ),
              ),
              if (_selectedExams.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: colorScheme.surfaceContainer,
                  child: SafeArea(
                    top: false,
                    child: FilledButton.icon(
                      onPressed: _addToTimetable,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(
                        'Add ${_selectedExams.length} course${_selectedExams.length > 1 ? 's' : ''} to timetable',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Shared centered icon + message layout for the search screen's prompt
/// and no-results states.
class _SearchInfoState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? hint;

  const _SearchInfoState({
    required this.icon,
    required this.title,
    this.subtitle,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (hint != null) ...[
              const SizedBox(height: 4),
              Text(
                hint!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
