# Firebase Remote Config Feature

This feature provides a complete Firebase Remote Config integration using Clean Architecture principles, allowing you to dynamically configure your app's behavior and appearance without requiring app updates.

## Features

- ✅ Firebase Remote Config integration
- ✅ Local caching for offline support
- ✅ Type-safe parameter retrieval (String, Bool, Int, Double, JSON)
- ✅ Default value management
- ✅ Settings configuration
- ✅ Fetch and activate remote values
- ✅ Config staleness checking
- ✅ Comprehensive error handling
- ✅ BLoC state management
- ✅ Clean Architecture implementation

## Architecture

The feature follows Clean Architecture principles with:

- **Domain Layer**: Entities, repositories, and use cases
- **Data Layer**: Remote and local data sources, models, and repository implementation
- **Presentation Layer**: BLoC for state management

## Usage

### 1. Initialize Remote Config

```dart
// In your app initialization
final remoteConfigBloc = context.read<RemoteConfigBloc>();
remoteConfigBloc.add(const InitializeRemoteConfigEvent());
```

### 2. Fetch and Activate Remote Values

```dart
// Fetch the latest remote config values
remoteConfigBloc.add(const FetchAndActivateEvent());
```

### 3. Get Remote Config Values

```dart
// Get a string value
remoteConfigBloc.add(const GetStringEvent(
  key: 'welcome_message',
  defaultValue: 'Welcome to Academia!',
));

// Get a boolean value
remoteConfigBloc.add(const GetBoolEvent(
  key: 'feature_enabled',
  defaultValue: false,
));

// Get an integer value
remoteConfigBloc.add(const GetIntEvent(
  key: 'max_retry_attempts',
  defaultValue: 3,
));

// Get a double value
remoteConfigBloc.add(const GetDoubleEvent(
  key: 'timeout_duration',
  defaultValue: 30.0,
));

// Get a JSON value
remoteConfigBloc.add(const GetJsonEvent(
  key: 'user_preferences',
  defaultValue: {
    'theme': 'light',
    'language': 'en',
    'notifications_enabled': true,
  },
));
```

### 4. Listen to Remote Config States

```dart
BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
  builder: (context, state) {
    if (state is StringValueLoadedState) {
      return Text(state.value);
    } else if (state is BoolValueLoadedState) {
      return Switch(
        value: state.value,
        onChanged: (value) {
          // Handle value change
        },
      );
    } else if (state is IntValueLoadedState) {
      return Text('${state.value}');
    } else if (state is DoubleValueLoadedState) {
      return Text('${state.value}');
    } else if (state is JsonValueLoadedState) {
      return Text(JsonEncoder.withIndent('  ').convert(state.value));
    } else if (state is RemoteConfigLoadingState) {
      return const CircularProgressIndicator();
    } else if (state is RemoteConfigErrorState) {
      return Text('Error: ${state.message}');
    }
    return const SizedBox.shrink();
  },
)
```

### 5. Get All Parameters

```dart
remoteConfigBloc.add(const GetAllParametersEvent());

// Listen to all parameters
BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
  builder: (context, state) {
    if (state is AllParametersLoadedState) {
      return ListView.builder(
        itemCount: state.parameters.length,
        itemBuilder: (context, index) {
          final key = state.parameters.keys.elementAt(index);
          final value = state.parameters[key];
          return ListTile(
            title: Text(key),
            subtitle: Text(value.toString()),
          );
        },
      );
    }
    return const CircularProgressIndicator();
  },
)
```

### 6. Set Default Values

```dart
remoteConfigBloc.add(SetDefaultsEvent(defaults: {
  'welcome_message': 'Welcome to Academia!',
  'new_ui_enabled': false,
  'beta_features_enabled': false,
  'max_retry_attempts': 3,
  'timeout_duration': 30.0,
  'user_preferences': jsonEncode({
    'theme': 'light',
    'language': 'en',
    'notifications_enabled': true,
  }),
}));
```

### 7. Manage Settings

```dart
// Get current settings
remoteConfigBloc.add(const GetSettingsEvent());

// Set new settings
remoteConfigBloc.add(SetSettingsEvent(settings: RemoteConfigSettingsEntity(
  fetchTimeout: const Duration(minutes: 1),
  minimumFetchInterval: const Duration(hours: 1),
  isDeveloperMode: false,
)));
```

## Available Events

- `InitializeRemoteConfigEvent()`
- `FetchAndActivateEvent()`
- `GetStringEvent(key: String, defaultValue: String)`
- `GetBoolEvent(key: String, defaultValue: bool)`
- `GetIntEvent(key: String, defaultValue: int)`
- `GetDoubleEvent(key: String, defaultValue: double)`
- `GetJsonEvent(key: String, defaultValue: Map<String, dynamic>?)`
- `GetAllParametersEvent()`
- `SetDefaultsEvent(defaults: Map<String, dynamic>)`
- `GetSettingsEvent()`
- `SetSettingsEvent(settings: RemoteConfigSettingsEntity)`

## Available States

- `RemoteConfigInitialState`
- `RemoteConfigLoadingState`
- `RemoteConfigInitializedState`
- `RemoteConfigFetchedState`
- `StringValueLoadedState(key: String, value: String)`
- `BoolValueLoadedState(key: String, value: bool)`
- `IntValueLoadedState(key: String, value: int)`
- `DoubleValueLoadedState(key: String, value: double)`
- `JsonValueLoadedState(key: String, value: Map<String, dynamic>)`
- `AllParametersLoadedState(parameters: Map<String, dynamic>)`
- `DefaultsSetState`
- `SettingsLoadedState(settings: RemoteConfigSettingsEntity)`
- `SettingsSetState`
- `RemoteConfigErrorState(message: String)`

## Setup

1. Add Firebase Remote Config dependency to `pubspec.yaml`:
   ```yaml
   dependencies:
     firebase_remote_config: ^5.0.18
   ```

2. Configure Firebase in your project:
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Initialize Firebase in your app

3. Register the BLoC in your dependency injection:
   ```dart
   // In your dependency injection setup
     sl.registerLazySingleton<RemoteConfigBloc>(() => RemoteConfigBloc(
    initializeUsecase: sl<InitializeRemoteConfigUsecase>(),
    fetchAndActivateUsecase: sl<FetchAndActivateUsecase>(),
    getStringUsecase: sl<GetStringUsecase>(),
    getBoolUsecase: sl<GetBoolUsecase>(),
    getIntUsecase: sl<GetIntUsecase>(),
    getDoubleUsecase: sl<GetDoubleUsecase>(),
    getJsonUsecase: sl<GetJsonUsecase>(),
    getAllParametersUsecase: sl<GetAllParametersUsecase>(),
    setDefaultsUsecase: sl<SetDefaultsUsecase>(),
    getSettingsUsecase: sl<GetSettingsUsecase>(),
    setSettingsUsecase: sl<SetSettingsUsecase>(),
  ));
   ```

4. Initialize Remote Config in your app startup:
   ```dart
   // In your main.dart or app initialization
   final remoteConfigBloc = context.read<RemoteConfigBloc>();
   remoteConfigBloc.add(const InitializeRemoteConfigEvent());
   ```

## Error Handling

The feature includes comprehensive error handling with custom `RemoteConfigFailure` for Firebase operations and `CacheFailure` for local storage operations.

## Caching

Remote config values are automatically cached locally using SharedPreferences for offline support. The cache includes:
- Remote config parameters
- Last fetch time
- Last activated time
- Settings configuration

## Best Practices

1. **Initialize Early**: Initialize Remote Config as early as possible in your app lifecycle
2. **Set Defaults**: Always provide sensible default values for all remote config parameters
3. **Handle Errors**: Always handle error states in your UI
4. **Cache Strategy**: The feature automatically handles caching, but you can customize the cache duration
5. **Type Safety**: Use the appropriate getter methods for type safety
6. **Testing**: Use the default values for testing and development
7. **Value Types**: Firebase Remote Config only supports primitive types (String, bool, int, double) as default values. For complex objects, use JSON strings.

## Firebase Remote Config Limitations

Firebase Remote Config has some limitations to be aware of:

- **Default Values**: Only primitive types (String, bool, int, double) are supported as default values
- **Complex Objects**: For complex objects like Maps or Lists, convert them to JSON strings using `jsonEncode()`
- **Nested Objects**: Avoid nested objects in default values; flatten the structure or use JSON strings
- **Value Size**: There are limits on the size of individual parameter values

### Example of Correct Default Values:
```dart
// ✅ Correct - Primitive types
'welcome_message': 'Welcome to Academia!',
'new_ui_enabled': false,
'max_retry_attempts': 3,
'timeout_duration': 30.0,

// ✅ Correct - Complex objects as JSON strings
'user_preferences': jsonEncode({
  'theme': 'light',
  'language': 'en',
  'notifications_enabled': true,
}),

// ❌ Incorrect - Nested objects
'feature_flags': {
  'new_ui_enabled': false,
  'beta_features_enabled': false,
},
```

## Example Implementation

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<RemoteConfigBloc>()
        ..add(const InitializeRemoteConfigEvent())
        ..add(const FetchAndActivateEvent()),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
          builder: (context, state) {
            if (state is StringValueLoadedState && state.key == 'app_title') {
              return Text(state.value);
            }
            return const Text('Academia');
          },
        ),
      ),
      body: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
        builder: (context, state) {
          if (state is BoolValueLoadedState && state.key == 'show_beta_features') {
            return state.value 
              ? BetaFeaturesWidget()
              : StandardFeaturesWidget();
          }
          return const StandardFeaturesWidget();
        },
      ),
    );
  }
}
```

## Firebase Console Configuration

1. Go to Firebase Console > Remote Config
2. Add parameters with appropriate values
3. Set up conditions for different user segments
4. Publish changes to make them available to your app

## Troubleshooting

- **Initialization Issues**: Ensure Firebase is properly initialized before using Remote Config
- **Network Issues**: The feature falls back to cached values when network is unavailable
- **Parameter Not Found**: Always provide default values to handle missing parameters
- **Type Mismatches**: Use the correct getter method for the expected data type
