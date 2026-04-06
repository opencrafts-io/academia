import 'package:academia/features/sherehe/presentation/bloc/create_event/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Stage4ReviewAndSubmit extends StatelessWidget {
  final String userName;
  final VoidCallback onSubmit;
  final VoidCallback onPrevious;

  const Stage4ReviewAndSubmit({
    super.key,
    required this.userName,
    required this.onSubmit,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            spacing: 8.0, 
            children: [
              const Text("Creating event as:"),
              Text(
                userName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            spacing: 20.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Submit Button
              Row(
                spacing: 16.0,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onPrevious,
                      child: const Text('Back'),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<CreateEventBloc, CreateEventState>(
                      builder: (context, state) {
                        final isSubmitting = state is CreateEventLoading;
                        return FilledButton.icon(
                          onPressed: isSubmitting ? null : onSubmit,
                          icon: isSubmitting
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.check),
                          label: Text(
                            isSubmitting ? 'Creating...' : 'Create Event',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Posting events may be subject to changes. Please stay tuned for updates.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
