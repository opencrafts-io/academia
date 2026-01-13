import 'package:academia/features/sherehe/presentation/bloc/create_event/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Stage4ReviewAndSubmit extends StatelessWidget {
  final String userName;
  final VoidCallback onSubmit;
  final VoidCallback onPrevious;
  final BuildContext context;

  const Stage4ReviewAndSubmit({
    super.key,
    required this.userName,
    required this.onSubmit,
    required this.onPrevious,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Column(
            children: [
              const Text("Creating event as:"),
              const SizedBox(height: 8),
              Text(
                userName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Submit Button
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onPrevious,
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: BlocBuilder<CreateEventBloc, CreateEventState>(
                  builder: (context, state) {
                    final isSubmitting = state is CreateEventLoading;
                    return FilledButton.icon(
                      onPressed: isSubmitting
                          ? null
                          : onSubmit,
                      icon: isSubmitting
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
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
          const SizedBox(height: 20),
          Center(
            child: Text(
              "Posting events may be subject to changes. Please stay tuned for updates.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
