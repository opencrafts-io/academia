import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigTestWidget extends StatelessWidget {
  const RemoteConfigTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config Test'),
      ),
      body: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remote Config Status:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(state),
                const SizedBox(height: 24),
                _buildActionButtons(context),
                const SizedBox(height: 24),
                _buildValueDisplay(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard(RemoteConfigState state) {
    String status;
    Color color;
    IconData icon;

    if (state is RemoteConfigInitialState) {
      status = 'Initial';
      color = Colors.grey;
      icon = Icons.help_outline;
    } else if (state is RemoteConfigLoadingState) {
      status = 'Loading...';
      color = Colors.orange;
      icon = Icons.hourglass_empty;
    } else if (state is RemoteConfigInitializedState) {
      status = 'Initialized';
      color = Colors.blue;
      icon = Icons.check_circle_outline;
    } else if (state is RemoteConfigFetchedState) {
      status = 'Fetched & Activated';
      color = Colors.green;
      icon = Icons.check_circle;
    } else if (state is RemoteConfigErrorState) {
      status = 'Error: ${state.message}';
      color = Colors.red;
      icon = Icons.error;
    } else {
      status = 'Unknown State';
      color = Colors.grey;
      icon = Icons.help_outline;
    }

    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<RemoteConfigBloc>().add(
                      const InitializeRemoteConfigEvent(),
                    );
              },
              child: const Text('Initialize'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RemoteConfigBloc>().add(
                      const FetchAndActivateEvent(),
                    );
              },
              child: const Text('Fetch & Activate'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RemoteConfigBloc>().add(
                      const GetStringEvent(key: 'welcome_message'),
                    );
              },
              child: const Text('Get Welcome Message'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RemoteConfigBloc>().add(
                      const GetBoolEvent(key: 'new_ui_enabled'),
                    );
              },
              child: const Text('Get UI Flag'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildValueDisplay(BuildContext context, RemoteConfigState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Values:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (state is StringValueLoadedState)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: ${state.key}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Value: ${state.value}'),
                ],
              ),
            ),
          ),
        if (state is BoolValueLoadedState)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: ${state.key}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Value: ${state.value}'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

