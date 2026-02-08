import 'package:academia/features/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: course.color?.withAlpha(32),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 12),
        title: Text(
          course.courseName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: CircleAvatar(child: Icon(Icons.school_outlined)),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              course.courseCode,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.person, size: 16),
                SizedBox(width: 4),
                Text(
                  course.instructor,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Feature coming soon!'),
                  ),
                );
              },
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'delete',
              onTap: () {
                context.read<CourseCubit>().removeCourse(course.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Course removed successfully'),
                  ),
                );
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
