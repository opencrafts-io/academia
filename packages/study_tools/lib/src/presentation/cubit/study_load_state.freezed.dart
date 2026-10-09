// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'study_load_state.dart';

mixin _$StudyLoadState {}

extension StudyLoadStatePatterns on StudyLoadState {
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message, String? code) failure,
  }) => switch (this) {
    StudyLoadInitial() => initial(),
    StudyLoadLoading() => loading(),
    StudyLoadLoaded() => loaded(),
    StudyLoadFailure(:final message, :final code) => failure(message, code),
  };

  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message, String? code)? failure,
    required TResult Function() orElse,
  }) => switch (this) {
    StudyLoadInitial() when initial != null => initial(),
    StudyLoadLoading() when loading != null => loading(),
    StudyLoadLoaded() when loaded != null => loaded(),
    StudyLoadFailure(:final message, :final code) when failure != null =>
      failure(message, code),
    _ => orElse(),
  };
}

final class StudyLoadInitial extends StudyLoadState {
  const StudyLoadInitial();

  @override
  bool operator ==(Object other) => other is StudyLoadInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class StudyLoadLoading extends StudyLoadState {
  const StudyLoadLoading();

  @override
  bool operator ==(Object other) => other is StudyLoadLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class StudyLoadLoaded extends StudyLoadState {
  const StudyLoadLoaded();

  @override
  bool operator ==(Object other) => other is StudyLoadLoaded;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class StudyLoadFailure extends StudyLoadState {
  const StudyLoadFailure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  bool operator ==(Object other) =>
      other is StudyLoadFailure &&
      other.message == message &&
      other.code == code;

  @override
  int get hashCode => Object.hash(runtimeType, message, code);
}
