// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PodcastCubitState {

 List<PodcastDownloadedEpisode> get downloads; bool get isLoadingDownloads; bool get isDownloading; int? get receivedBytes; int? get totalBytes; MediaItem? get currentMediaItem; PlaybackState? get playbackState; String? get error; PodcastAccessIssue get accessIssue;
/// Create a copy of PodcastCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastCubitStateCopyWith<PodcastCubitState> get copyWith => _$PodcastCubitStateCopyWithImpl<PodcastCubitState>(this as PodcastCubitState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PodcastCubitState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastCubitState&&const DeepCollectionEquality().equals(other.downloads, _this.downloads)&&(identical(other.isLoadingDownloads, _this.isLoadingDownloads) || other.isLoadingDownloads == _this.isLoadingDownloads)&&(identical(other.isDownloading, _this.isDownloading) || other.isDownloading == _this.isDownloading)&&(identical(other.receivedBytes, _this.receivedBytes) || other.receivedBytes == _this.receivedBytes)&&(identical(other.totalBytes, _this.totalBytes) || other.totalBytes == _this.totalBytes)&&(identical(other.currentMediaItem, _this.currentMediaItem) || other.currentMediaItem == _this.currentMediaItem)&&(identical(other.playbackState, _this.playbackState) || other.playbackState == _this.playbackState)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.accessIssue, _this.accessIssue) || other.accessIssue == _this.accessIssue));
}


@override
int get hashCode {
  final _this = this as PodcastCubitState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.downloads),_this.isLoadingDownloads,_this.isDownloading,_this.receivedBytes,_this.totalBytes,_this.currentMediaItem,_this.playbackState,_this.error,_this.accessIssue);
}

@override
String toString() {
  final _this = this as PodcastCubitState;
  return 'PodcastCubitState(downloads: ${_this.downloads}, isLoadingDownloads: ${_this.isLoadingDownloads}, isDownloading: ${_this.isDownloading}, receivedBytes: ${_this.receivedBytes}, totalBytes: ${_this.totalBytes}, currentMediaItem: ${_this.currentMediaItem}, playbackState: ${_this.playbackState}, error: ${_this.error}, accessIssue: ${_this.accessIssue})';
}


}

/// @nodoc
abstract mixin class $PodcastCubitStateCopyWith<$Res>  {
  factory $PodcastCubitStateCopyWith(PodcastCubitState value, $Res Function(PodcastCubitState) _then) = _$PodcastCubitStateCopyWithImpl;
@useResult
$Res call({
 List<PodcastDownloadedEpisode> downloads, bool isLoadingDownloads, bool isDownloading, int? receivedBytes, int? totalBytes, MediaItem? currentMediaItem, PlaybackState? playbackState, String? error, PodcastAccessIssue accessIssue
});




}
/// @nodoc
class _$PodcastCubitStateCopyWithImpl<$Res>
    implements $PodcastCubitStateCopyWith<$Res> {
  _$PodcastCubitStateCopyWithImpl(this._self, this._then);

  final PodcastCubitState _self;
  final $Res Function(PodcastCubitState) _then;

/// Create a copy of PodcastCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? downloads = null,Object? isLoadingDownloads = null,Object? isDownloading = null,Object? receivedBytes = freezed,Object? totalBytes = freezed,Object? currentMediaItem = freezed,Object? playbackState = freezed,Object? error = freezed,Object? accessIssue = null,}) {
  return _then(PodcastCubitState(
downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as List<PodcastDownloadedEpisode>,isLoadingDownloads: null == isLoadingDownloads ? _self.isLoadingDownloads : isLoadingDownloads // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,receivedBytes: freezed == receivedBytes ? _self.receivedBytes : receivedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,currentMediaItem: freezed == currentMediaItem ? _self.currentMediaItem : currentMediaItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,playbackState: freezed == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,accessIssue: null == accessIssue ? _self.accessIssue : accessIssue // ignore: cast_nullable_to_non_nullable
as PodcastAccessIssue,
  ));
}

}


/// Adds pattern-matching-related methods to [PodcastCubitState].
extension PodcastCubitStatePatterns on PodcastCubitState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PodcastCubitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PodcastCubitState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PodcastCubitState value)  $default,){
final _that = this;
switch (_that) {
case _PodcastCubitState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PodcastCubitState value)?  $default,){
final _that = this;
switch (_that) {
case _PodcastCubitState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PodcastDownloadedEpisode> downloads,  bool isLoadingDownloads,  bool isDownloading,  int? receivedBytes,  int? totalBytes,  MediaItem? currentMediaItem,  PlaybackState? playbackState,  String? error,  PodcastAccessIssue accessIssue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PodcastCubitState() when $default != null:
return $default(_that.downloads,_that.isLoadingDownloads,_that.isDownloading,_that.receivedBytes,_that.totalBytes,_that.currentMediaItem,_that.playbackState,_that.error,_that.accessIssue);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PodcastDownloadedEpisode> downloads,  bool isLoadingDownloads,  bool isDownloading,  int? receivedBytes,  int? totalBytes,  MediaItem? currentMediaItem,  PlaybackState? playbackState,  String? error,  PodcastAccessIssue accessIssue)  $default,) {final _that = this;
switch (_that) {
case _PodcastCubitState():
return $default(_that.downloads,_that.isLoadingDownloads,_that.isDownloading,_that.receivedBytes,_that.totalBytes,_that.currentMediaItem,_that.playbackState,_that.error,_that.accessIssue);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PodcastDownloadedEpisode> downloads,  bool isLoadingDownloads,  bool isDownloading,  int? receivedBytes,  int? totalBytes,  MediaItem? currentMediaItem,  PlaybackState? playbackState,  String? error,  PodcastAccessIssue accessIssue)?  $default,) {final _that = this;
switch (_that) {
case _PodcastCubitState() when $default != null:
return $default(_that.downloads,_that.isLoadingDownloads,_that.isDownloading,_that.receivedBytes,_that.totalBytes,_that.currentMediaItem,_that.playbackState,_that.error,_that.accessIssue);case _:
  return null;

}
}

}

/// @nodoc


class _PodcastCubitState implements PodcastCubitState {
  const _PodcastCubitState({ List<PodcastDownloadedEpisode> downloads = const <PodcastDownloadedEpisode>[], this.isLoadingDownloads = false, this.isDownloading = false, this.receivedBytes, this.totalBytes, this.currentMediaItem, this.playbackState, this.error, this.accessIssue = PodcastAccessIssue.none}): _downloads = downloads;


 final  List<PodcastDownloadedEpisode> _downloads;
@override@JsonKey() List<PodcastDownloadedEpisode> get downloads {
  if (_downloads is EqualUnmodifiableListView) return _downloads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_downloads);
}

@override@JsonKey() final  bool isLoadingDownloads;
@override@JsonKey() final  bool isDownloading;
@override final  int? receivedBytes;
@override final  int? totalBytes;
@override final  MediaItem? currentMediaItem;
@override final  PlaybackState? playbackState;
@override final  String? error;
@override@JsonKey() final  PodcastAccessIssue accessIssue;

/// Create a copy of PodcastCubitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastCubitStateCopyWith<_PodcastCubitState> get copyWith => __$PodcastCubitStateCopyWithImpl<_PodcastCubitState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PodcastCubitState&&const DeepCollectionEquality().equals(other.downloads, _downloads)&&(identical(other.isLoadingDownloads, isLoadingDownloads) || other.isLoadingDownloads == isLoadingDownloads)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.receivedBytes, receivedBytes) || other.receivedBytes == receivedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.currentMediaItem, currentMediaItem) || other.currentMediaItem == currentMediaItem)&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState)&&(identical(other.error, error) || other.error == error)&&(identical(other.accessIssue, accessIssue) || other.accessIssue == accessIssue));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_downloads),isLoadingDownloads,isDownloading,receivedBytes,totalBytes,currentMediaItem,playbackState,error,accessIssue);
}

@override
String toString() {
    return 'PodcastCubitState(downloads: $downloads, isLoadingDownloads: $isLoadingDownloads, isDownloading: $isDownloading, receivedBytes: $receivedBytes, totalBytes: $totalBytes, currentMediaItem: $currentMediaItem, playbackState: $playbackState, error: $error, accessIssue: $accessIssue)';
}


}

/// @nodoc
abstract mixin class _$PodcastCubitStateCopyWith<$Res> implements $PodcastCubitStateCopyWith<$Res> {
  factory _$PodcastCubitStateCopyWith(_PodcastCubitState value, $Res Function(_PodcastCubitState) _then) = __$PodcastCubitStateCopyWithImpl;
@override @useResult
$Res call({
 List<PodcastDownloadedEpisode> downloads, bool isLoadingDownloads, bool isDownloading, int? receivedBytes, int? totalBytes, MediaItem? currentMediaItem, PlaybackState? playbackState, String? error, PodcastAccessIssue accessIssue
});




}
/// @nodoc
class __$PodcastCubitStateCopyWithImpl<$Res>
    implements _$PodcastCubitStateCopyWith<$Res> {
  __$PodcastCubitStateCopyWithImpl(this._self, this._then);

  final _PodcastCubitState _self;
  final $Res Function(_PodcastCubitState) _then;

/// Create a copy of PodcastCubitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? downloads = null,Object? isLoadingDownloads = null,Object? isDownloading = null,Object? receivedBytes = freezed,Object? totalBytes = freezed,Object? currentMediaItem = freezed,Object? playbackState = freezed,Object? error = freezed,Object? accessIssue = null,}) {
  return _then(_PodcastCubitState(
downloads: null == downloads ? _self._downloads : downloads // ignore: cast_nullable_to_non_nullable
as List<PodcastDownloadedEpisode>,isLoadingDownloads: null == isLoadingDownloads ? _self.isLoadingDownloads : isLoadingDownloads // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,receivedBytes: freezed == receivedBytes ? _self.receivedBytes : receivedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,currentMediaItem: freezed == currentMediaItem ? _self.currentMediaItem : currentMediaItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,playbackState: freezed == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,accessIssue: null == accessIssue ? _self.accessIssue : accessIssue // ignore: cast_nullable_to_non_nullable
as PodcastAccessIssue,
  ));
}


}

// dart format on
