import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final InitializeRemoteConfigUsecase initializeUsecase;
  final FetchAndActivateUsecase fetchAndActivateUsecase;
  final GetStringUsecase getStringUsecase;
  final GetBoolUsecase getBoolUsecase;
  final GetIntUsecase getIntUsecase;
  final GetDoubleUsecase getDoubleUsecase;
  final GetJsonUsecase getJsonUsecase;
  final GetAllParametersUsecase getAllParametersUsecase;
  final SetDefaultsUsecase setDefaultsUsecase;
  final GetSettingsUsecase getSettingsUsecase;
  final SetSettingsUsecase setSettingsUsecase;
  final Logger _logger = Logger();

  RemoteConfigBloc({
    required this.initializeUsecase,
    required this.fetchAndActivateUsecase,
    required this.getStringUsecase,
    required this.getBoolUsecase,
    required this.getIntUsecase,
    required this.getDoubleUsecase,
    required this.getJsonUsecase,
    required this.getAllParametersUsecase,
    required this.setDefaultsUsecase,
    required this.getSettingsUsecase,
    required this.setSettingsUsecase,
  }) : super(const RemoteConfigInitialState()) {
    on<InitializeRemoteConfigEvent>(_onInitializeRemoteConfig);
    on<FetchAndActivateEvent>(_onFetchAndActivate);
    on<GetStringEvent>(_onGetString);
    on<GetBoolEvent>(_onGetBool);
    on<GetIntEvent>(_onGetInt);
    on<GetDoubleEvent>(_onGetDouble);
    on<GetJsonEvent>(_onGetJson);
    on<GetAllParametersEvent>(_onGetAllParameters);
    on<SetDefaultsEvent>(_onSetDefaults);
    on<GetSettingsEvent>(_onGetSettings);
    on<SetSettingsEvent>(_onSetSettings);
  }

  Future<void> _onInitializeRemoteConfig(
    InitializeRemoteConfigEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await initializeUsecase(NoParams());

      result.fold(
        (failure) {
          _logger.e('Failed to initialize Remote Config: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (_) {
          emit(const RemoteConfigInitializedState());
        },
      );
    } catch (e) {
      _logger.e('Error initializing Remote Config', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchAndActivate(
    FetchAndActivateEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await fetchAndActivateUsecase(NoParams());

      result.fold(
        (failure) {
          _logger.e('Failed to fetch and activate: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (_) {
          emit(const RemoteConfigFetchedState());
        },
      );
    } catch (e) {
      _logger.e('Error fetching and activating Remote Config', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetString(
    GetStringEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getStringUsecase(GetStringParams(
        key: event.key,
        defaultValue: event.defaultValue,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to get string value: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (value) {
          emit(StringValueLoadedState(key: event.key, value: value));
        },
      );
    } catch (e) {
      _logger.e('Error getting string value', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetBool(
    GetBoolEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getBoolUsecase(GetBoolParams(
        key: event.key,
        defaultValue: event.defaultValue,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to get boolean value: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (value) {
          emit(BoolValueLoadedState(key: event.key, value: value));
        },
      );
    } catch (e) {
      _logger.e('Error getting boolean value', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetInt(
    GetIntEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getIntUsecase(GetIntParams(
        key: event.key,
        defaultValue: event.defaultValue,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to get integer value: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (value) {
          emit(IntValueLoadedState(key: event.key, value: value));
        },
      );
    } catch (e) {
      _logger.e('Error getting integer value', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetDouble(
    GetDoubleEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getDoubleUsecase(GetDoubleParams(
        key: event.key,
        defaultValue: event.defaultValue,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to get double value: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (value) {
          emit(DoubleValueLoadedState(key: event.key, value: value));
        },
      );
    } catch (e) {
      _logger.e('Error getting double value', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetJson(
    GetJsonEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getJsonUsecase(GetJsonParams(
        key: event.key,
        defaultValue: event.defaultValue,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to get JSON value: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (value) {
          emit(JsonValueLoadedState(key: event.key, value: value));
        },
      );
    } catch (e) {
      _logger.e('Error getting JSON value', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetAllParameters(
    GetAllParametersEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getAllParametersUsecase(NoParams());

      result.fold(
        (failure) {
          _logger.e('Failed to get all parameters: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (parameters) {
          emit(AllParametersLoadedState(parameters: parameters));
        },
      );
    } catch (e) {
      _logger.e('Error getting all parameters', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onSetDefaults(
    SetDefaultsEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await setDefaultsUsecase(SetDefaultsParams(
        defaults: event.defaults,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to set defaults: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (_) {
          emit(const DefaultsSetState());
        },
      );
    } catch (e) {
      _logger.e('Error setting defaults', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetSettings(
    GetSettingsEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await getSettingsUsecase(NoParams());

      result.fold(
        (failure) {
          _logger.e('Failed to get settings: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (settings) {
          emit(SettingsLoadedState(settings: settings));
        },
      );
    } catch (e) {
      _logger.e('Error getting settings', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }

  Future<void> _onSetSettings(
    SetSettingsEvent event,
    Emitter<RemoteConfigState> emit,
  ) async {
    try {
      emit(const RemoteConfigLoadingState());

      final result = await setSettingsUsecase(SetSettingsParams(
        settings: event.settings,
      ));

      result.fold(
        (failure) {
          _logger.e('Failed to set settings: ${failure.message}');
          emit(RemoteConfigErrorState(message: failure.message));
        },
        (_) {
          emit(const SettingsSetState());
        },
      );
    } catch (e) {
      _logger.e('Error setting settings', error: e);
      emit(RemoteConfigErrorState(message: e.toString()));
    }
  }
}
