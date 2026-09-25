import 'package:courses/src/presentation/screens/course_list_page.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseHistoryPage extends StatefulWidget {
  const CourseHistoryPage({super.key});

  @override
  State<CourseHistoryPage> createState() => _CourseHistoryPageState();
}

class _CourseHistoryPageState extends State<CourseHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadArchived();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    return CourseListBody(
      courses: state.courses,
      loading: state.isLoading,
      error: state.error,
      onRefresh: () => context.read<CourseCubit>().loadArchived(),
      archived: true,
    );
  }
}
