import 'package:academia/features/exam_timetable/presentation/widgets/exam_search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';

class ExamTimetableSearchScreen extends StatefulWidget {
  final String institutionId;

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
          AddExamsToTimetable(exams: examsToAdd),
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
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: _isSearching
                ? _searchController.text
                : 'BIL111K, ENG111R, MAT121K',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          onSubmitted: (_) => _performSearch(),
          textInputAction: TextInputAction.search,
        ),
        actions: [
          if (_searchController.text.isNotEmpty && _isSearching)
            IconButton(
              icon: Icon(Icons.close, color: colorScheme.onSurface),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          if (!_isSearching) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Provide courses to search for.',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Separate multiple course codes with commas',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Example: BIL111K, ENG111R, MAT121K',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
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
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: ElevatedButton(
                      onPressed: _addToTimetable,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add ${_selectedExams.length} course${_selectedExams.length > 1 ? 's' : ''} to timetable',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
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
