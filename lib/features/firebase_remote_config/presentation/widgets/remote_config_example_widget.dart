import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert';

class RemoteConfigExampleWidget extends StatelessWidget {
  const RemoteConfigExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<RemoteConfigBloc>().add(const FetchAndActivateEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
        builder: (context, state) {
          if (state is RemoteConfigLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteConfigErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RemoteConfigBloc>().add(
                            const InitializeRemoteConfigEvent(),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Welcome Message',
                  child: _buildStringValueWidget(context, 'welcome_message'),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Feature Flags',
                  child: Column(
                    children: [
                      _buildBoolValueWidget(context, 'new_ui_enabled'),
                      const SizedBox(height: 8),
                      _buildBoolValueWidget(context, 'beta_features_enabled'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'App Configuration',
                  child: Column(
                    children: [
                      _buildIntValueWidget(context, 'max_retry_attempts'),
                      const SizedBox(height: 8),
                      _buildDoubleValueWidget(context, 'timeout_duration'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'User Preferences (JSON)',
                  child: _buildJsonValueWidget(context, 'user_preferences'),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Actions',
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<RemoteConfigBloc>().add(
                                const GetAllParametersEvent(),
                              );
                        },
                        child: const Text('Get All Parameters'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RemoteConfigBloc>().add(
                                const GetSettingsEvent(),
                              );
                        },
                        child: const Text('Get Settings'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildAllParametersSection(context),
                const SizedBox(height: 24),
                _buildSettingsSection(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildStringValueWidget(BuildContext context, String key) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is StringValueLoadedState && state.key == key) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: $key',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Value: ${state.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<RemoteConfigBloc>().add(
                  GetStringEvent(
                    key: key,
                    defaultValue: 'Default $key',
                  ),
                );
          },
          child: Text('Get $key'),
        );
      },
    );
  }

  Widget _buildBoolValueWidget(BuildContext context, String key) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is BoolValueLoadedState && state.key == key) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: $key',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Value: ${state.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: state.value,
                        onChanged: (value) {
                          // In a real app, you might want to update the remote config
                          // or handle the value change differently
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<RemoteConfigBloc>().add(
                  GetBoolEvent(
                    key: key,
                    defaultValue: false,
                  ),
                );
          },
          child: Text('Get $key'),
        );
      },
    );
  }

  Widget _buildIntValueWidget(BuildContext context, String key) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is IntValueLoadedState && state.key == key) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: $key',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Value: ${state.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<RemoteConfigBloc>().add(
                  GetIntEvent(
                    key: key,
                    defaultValue: 0,
                  ),
                );
          },
          child: Text('Get $key'),
        );
      },
    );
  }

  Widget _buildDoubleValueWidget(BuildContext context, String key) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is DoubleValueLoadedState && state.key == key) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: $key',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Value: ${state.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<RemoteConfigBloc>().add(
                  GetDoubleEvent(
                    key: key,
                    defaultValue: 0.0,
                  ),
                );
          },
          child: Text('Get $key'),
        );
      },
    );
  }

  Widget _buildJsonValueWidget(BuildContext context, String key) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is JsonValueLoadedState && state.key == key) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key: $key',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Value:',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      const JsonEncoder.withIndent('  ').convert(state.value),
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<RemoteConfigBloc>().add(
                  GetJsonEvent(
                    key: key,
                    defaultValue: {
                      'theme': 'light',
                      'language': 'en',
                      'notifications_enabled': true,
                    },
                  ),
                );
          },
          child: Text('Get $key'),
        );
      },
    );
  }

  Widget _buildAllParametersSection(BuildContext context) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is AllParametersLoadedState) {
          return _buildSection(
            title: 'All Parameters',
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.parameters.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.value.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        if (state is SettingsLoadedState) {
          return _buildSection(
            title: 'Settings',
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fetch Timeout: ${state.settings.fetchTimeout.inSeconds}s',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Minimum Fetch Interval: ${state.settings.minimumFetchInterval.inHours}h',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Developer Mode: ${state.settings.isDeveloperMode}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
