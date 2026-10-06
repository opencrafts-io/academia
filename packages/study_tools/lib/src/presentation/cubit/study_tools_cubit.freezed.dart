// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_tools_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyToolsState {

 StudyLoadStatus get status; List<StudyMaterial> get materials; StudyMaterial? get selectedMaterial; StudyPodcast? get podcast; bool get isLoadingPodcast; bool get isGeneratingPodcast; Map<QuestionFormat, List<QuestionSet>> get questionSets; QuestionFormat? get loadingFormat; Map<int, int> get jobs; Map<int, List<String>> get jobOutputs; String? get error; String? get errorCode; bool get isUploading; bool get generationBlocked;
/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyToolsStateCopyWith<StudyToolsState> get copyWith => _$StudyToolsStateCopyWithImpl<StudyToolsState>(this as StudyToolsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyToolsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyToolsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.materials, _this.materials)&&(identical(other.selectedMaterial, _this.selectedMaterial) || other.selectedMaterial == _this.selectedMaterial)&&(identical(other.podcast, _this.podcast) || other.podcast == _this.podcast)&&(identical(other.isLoadingPodcast, _this.isLoadingPodcast) || other.isLoadingPodcast == _this.isLoadingPodcast)&&(identical(other.isGeneratingPodcast, _this.isGeneratingPodcast) || other.isGeneratingPodcast == _this.isGeneratingPodcast)&&const DeepCollectionEquality().equals(other.questionSets, _this.questionSets)&&(identical(other.loadingFormat, _this.loadingFormat) || other.loadingFormat == _this.loadingFormat)&&const DeepCollectionEquality().equals(other.jobs, _this.jobs)&&const DeepCollectionEquality().equals(other.jobOutputs, _this.jobOutputs)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode)&&(identical(other.isUploading, _this.isUploading) || other.isUploading == _this.isUploading)&&(identical(other.generationBlocked, _this.generationBlocked) || other.generationBlocked == _this.generationBlocked));
}


@override
int get hashCode {
  final _this = this as StudyToolsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.materials),_this.selectedMaterial,_this.podcast,_this.isLoadingPodcast,_this.isGeneratingPodcast,const DeepCollectionEquality().hash(_this.questionSets),_this.loadingFormat,const DeepCollectionEquality().hash(_this.jobs),const DeepCollectionEquality().hash(_this.jobOutputs),_this.error,_this.errorCode,_this.isUploading,_this.generationBlocked);
}

@override
String toString() {
  final _this = this as StudyToolsState;
  return 'StudyToolsState(status: ${_this.status}, materials: ${_this.materials}, selectedMaterial: ${_this.selectedMaterial}, podcast: ${_this.podcast}, isLoadingPodcast: ${_this.isLoadingPodcast}, isGeneratingPodcast: ${_this.isGeneratingPodcast}, questionSets: ${_this.questionSets}, loadingFormat: ${_this.loadingFormat}, jobs: ${_this.jobs}, jobOutputs: ${_this.jobOutputs}, error: ${_this.error}, errorCode: ${_this.errorCode}, isUploading: ${_this.isUploading}, generationBlocked: ${_this.generationBlocked})';
}


}

/// @nodoc
abstract mixin class $StudyToolsStateCopyWith<$Res>  {
  factory $StudyToolsStateCopyWith(StudyToolsState value, $Res Function(StudyToolsState) _then) = _$StudyToolsStateCopyWithImpl;
@useResult
$Res call({
 StudyLoadStatus status, List<StudyMaterial> materials, StudyMaterial? selectedMaterial, StudyPodcast? podcast, bool isLoadingPodcast, bool isGeneratingPodcast, Map<QuestionFormat, List<QuestionSet>> questionSets, QuestionFormat? loadingFormat, Map<int, int> jobs, Map<int, List<String>> jobOutputs, String? error, String? errorCode, bool isUploading, bool generationBlocked
});


$StudyMaterialCopyWith<$Res>? get selectedMaterial;$StudyPodcastCopyWith<$Res>? get podcast;

}
/// @nodoc
class _$StudyToolsStateCopyWithImpl<$Res>
    implements $StudyToolsStateCopyWith<$Res> {
  _$StudyToolsStateCopyWithImpl(this._self, this._then);

  final StudyToolsState _self;
  final $Res Function(StudyToolsState) _then;

/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? materials = null,Object? selectedMaterial = freezed,Object? podcast = freezed,Object? isLoadingPodcast = null,Object? isGeneratingPodcast = null,Object? questionSets = null,Object? loadingFormat = freezed,Object? jobs = null,Object? jobOutputs = null,Object? error = freezed,Object? errorCode = freezed,Object? isUploading = null,Object? generationBlocked = null,}) {
  return _then(StudyToolsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyLoadStatus,materials: null == materials ? _self.materials : materials // ignore: cast_nullable_to_non_nullable
as List<StudyMaterial>,selectedMaterial: freezed == selectedMaterial ? _self.selectedMaterial : selectedMaterial // ignore: cast_nullable_to_non_nullable
as StudyMaterial?,podcast: freezed == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as StudyPodcast?,isLoadingPodcast: null == isLoadingPodcast ? _self.isLoadingPodcast : isLoadingPodcast // ignore: cast_nullable_to_non_nullable
as bool,isGeneratingPodcast: null == isGeneratingPodcast ? _self.isGeneratingPodcast : isGeneratingPodcast // ignore: cast_nullable_to_non_nullable
as bool,questionSets: null == questionSets ? _self.questionSets : questionSets // ignore: cast_nullable_to_non_nullable
as Map<QuestionFormat, List<QuestionSet>>,loadingFormat: freezed == loadingFormat ? _self.loadingFormat : loadingFormat // ignore: cast_nullable_to_non_nullable
as QuestionFormat?,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as Map<int, int>,jobOutputs: null == jobOutputs ? _self.jobOutputs : jobOutputs // ignore: cast_nullable_to_non_nullable
as Map<int, List<String>>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,generationBlocked: null == generationBlocked ? _self.generationBlocked : generationBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyMaterialCopyWith<$Res>? get selectedMaterial {
    if (_self.selectedMaterial == null) {
    return null;
  }

  return $StudyMaterialCopyWith<$Res>(_self.selectedMaterial!, (value) {
    return _then(_self.copyWith(selectedMaterial: value));
  });
}/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyPodcastCopyWith<$Res>? get podcast {
    if (_self.podcast == null) {
    return null;
  }

  return $StudyPodcastCopyWith<$Res>(_self.podcast!, (value) {
    return _then(_self.copyWith(podcast: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyToolsState].
extension StudyToolsStatePatterns on StudyToolsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyToolsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyToolsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyToolsState value)  $default,){
final _that = this;
switch (_that) {
case _StudyToolsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyToolsState value)?  $default,){
final _that = this;
switch (_that) {
case _StudyToolsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StudyLoadStatus status,  List<StudyMaterial> materials,  StudyMaterial? selectedMaterial,  StudyPodcast? podcast,  bool isLoadingPodcast,  bool isGeneratingPodcast,  Map<QuestionFormat, List<QuestionSet>> questionSets,  QuestionFormat? loadingFormat,  Map<int, int> jobs,  Map<int, List<String>> jobOutputs,  String? error,  String? errorCode,  bool isUploading,  bool generationBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyToolsState() when $default != null:
return $default(_that.status,_that.materials,_that.selectedMaterial,_that.podcast,_that.isLoadingPodcast,_that.isGeneratingPodcast,_that.questionSets,_that.loadingFormat,_that.jobs,_that.jobOutputs,_that.error,_that.errorCode,_that.isUploading,_that.generationBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StudyLoadStatus status,  List<StudyMaterial> materials,  StudyMaterial? selectedMaterial,  StudyPodcast? podcast,  bool isLoadingPodcast,  bool isGeneratingPodcast,  Map<QuestionFormat, List<QuestionSet>> questionSets,  QuestionFormat? loadingFormat,  Map<int, int> jobs,  Map<int, List<String>> jobOutputs,  String? error,  String? errorCode,  bool isUploading,  bool generationBlocked)  $default,) {final _that = this;
switch (_that) {
case _StudyToolsState():
return $default(_that.status,_that.materials,_that.selectedMaterial,_that.podcast,_that.isLoadingPodcast,_that.isGeneratingPodcast,_that.questionSets,_that.loadingFormat,_that.jobs,_that.jobOutputs,_that.error,_that.errorCode,_that.isUploading,_that.generationBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StudyLoadStatus status,  List<StudyMaterial> materials,  StudyMaterial? selectedMaterial,  StudyPodcast? podcast,  bool isLoadingPodcast,  bool isGeneratingPodcast,  Map<QuestionFormat, List<QuestionSet>> questionSets,  QuestionFormat? loadingFormat,  Map<int, int> jobs,  Map<int, List<String>> jobOutputs,  String? error,  String? errorCode,  bool isUploading,  bool generationBlocked)?  $default,) {final _that = this;
switch (_that) {
case _StudyToolsState() when $default != null:
return $default(_that.status,_that.materials,_that.selectedMaterial,_that.podcast,_that.isLoadingPodcast,_that.isGeneratingPodcast,_that.questionSets,_that.loadingFormat,_that.jobs,_that.jobOutputs,_that.error,_that.errorCode,_that.isUploading,_that.generationBlocked);case _:
  return null;

}
}

}

/// @nodoc


class _StudyToolsState implements StudyToolsState {
  const _StudyToolsState({this.status = StudyLoadStatus.initial,  List<StudyMaterial> materials = const <StudyMaterial>[], this.selectedMaterial, this.podcast, this.isLoadingPodcast = false, this.isGeneratingPodcast = false,  Map<QuestionFormat, List<QuestionSet>> questionSets = const <QuestionFormat, List<QuestionSet>>{}, this.loadingFormat,  Map<int, int> jobs = const <int, int>{},  Map<int, List<String>> jobOutputs = const <int, List<String>>{}, this.error, this.errorCode, this.isUploading = false, this.generationBlocked = false}): _materials = materials,_questionSets = questionSets,_jobs = jobs,_jobOutputs = jobOutputs;
  

@override@JsonKey() final  StudyLoadStatus status;
 final  List<StudyMaterial> _materials;
@override@JsonKey() List<StudyMaterial> get materials {
  if (_materials is EqualUnmodifiableListView) return _materials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_materials);
}

@override final  StudyMaterial? selectedMaterial;
@override final  StudyPodcast? podcast;
@override@JsonKey() final  bool isLoadingPodcast;
@override@JsonKey() final  bool isGeneratingPodcast;
 final  Map<QuestionFormat, List<QuestionSet>> _questionSets;
@override@JsonKey() Map<QuestionFormat, List<QuestionSet>> get questionSets {
  if (_questionSets is EqualUnmodifiableMapView) return _questionSets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_questionSets);
}

@override final  QuestionFormat? loadingFormat;
 final  Map<int, int> _jobs;
@override@JsonKey() Map<int, int> get jobs {
  if (_jobs is EqualUnmodifiableMapView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_jobs);
}

 final  Map<int, List<String>> _jobOutputs;
@override@JsonKey() Map<int, List<String>> get jobOutputs {
  if (_jobOutputs is EqualUnmodifiableMapView) return _jobOutputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_jobOutputs);
}

@override final  String? error;
@override final  String? errorCode;
@override@JsonKey() final  bool isUploading;
@override@JsonKey() final  bool generationBlocked;

/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyToolsStateCopyWith<_StudyToolsState> get copyWith => __$StudyToolsStateCopyWithImpl<_StudyToolsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyToolsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.materials, _materials)&&(identical(other.selectedMaterial, selectedMaterial) || other.selectedMaterial == selectedMaterial)&&(identical(other.podcast, podcast) || other.podcast == podcast)&&(identical(other.isLoadingPodcast, isLoadingPodcast) || other.isLoadingPodcast == isLoadingPodcast)&&(identical(other.isGeneratingPodcast, isGeneratingPodcast) || other.isGeneratingPodcast == isGeneratingPodcast)&&const DeepCollectionEquality().equals(other.questionSets, _questionSets)&&(identical(other.loadingFormat, loadingFormat) || other.loadingFormat == loadingFormat)&&const DeepCollectionEquality().equals(other.jobs, _jobs)&&const DeepCollectionEquality().equals(other.jobOutputs, _jobOutputs)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.generationBlocked, generationBlocked) || other.generationBlocked == generationBlocked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_materials),selectedMaterial,podcast,isLoadingPodcast,isGeneratingPodcast,const DeepCollectionEquality().hash(_questionSets),loadingFormat,const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_jobOutputs),error,errorCode,isUploading,generationBlocked);
}

@override
String toString() {
    return 'StudyToolsState(status: $status, materials: $materials, selectedMaterial: $selectedMaterial, podcast: $podcast, isLoadingPodcast: $isLoadingPodcast, isGeneratingPodcast: $isGeneratingPodcast, questionSets: $questionSets, loadingFormat: $loadingFormat, jobs: $jobs, jobOutputs: $jobOutputs, error: $error, errorCode: $errorCode, isUploading: $isUploading, generationBlocked: $generationBlocked)';
}


}

/// @nodoc
abstract mixin class _$StudyToolsStateCopyWith<$Res> implements $StudyToolsStateCopyWith<$Res> {
  factory _$StudyToolsStateCopyWith(_StudyToolsState value, $Res Function(_StudyToolsState) _then) = __$StudyToolsStateCopyWithImpl;
@override @useResult
$Res call({
 StudyLoadStatus status, List<StudyMaterial> materials, StudyMaterial? selectedMaterial, StudyPodcast? podcast, bool isLoadingPodcast, bool isGeneratingPodcast, Map<QuestionFormat, List<QuestionSet>> questionSets, QuestionFormat? loadingFormat, Map<int, int> jobs, Map<int, List<String>> jobOutputs, String? error, String? errorCode, bool isUploading, bool generationBlocked
});


@override $StudyMaterialCopyWith<$Res>? get selectedMaterial;@override $StudyPodcastCopyWith<$Res>? get podcast;

}
/// @nodoc
class __$StudyToolsStateCopyWithImpl<$Res>
    implements _$StudyToolsStateCopyWith<$Res> {
  __$StudyToolsStateCopyWithImpl(this._self, this._then);

  final _StudyToolsState _self;
  final $Res Function(_StudyToolsState) _then;

/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? materials = null,Object? selectedMaterial = freezed,Object? podcast = freezed,Object? isLoadingPodcast = null,Object? isGeneratingPodcast = null,Object? questionSets = null,Object? loadingFormat = freezed,Object? jobs = null,Object? jobOutputs = null,Object? error = freezed,Object? errorCode = freezed,Object? isUploading = null,Object? generationBlocked = null,}) {
  return _then(_StudyToolsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyLoadStatus,materials: null == materials ? _self._materials : materials // ignore: cast_nullable_to_non_nullable
as List<StudyMaterial>,selectedMaterial: freezed == selectedMaterial ? _self.selectedMaterial : selectedMaterial // ignore: cast_nullable_to_non_nullable
as StudyMaterial?,podcast: freezed == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as StudyPodcast?,isLoadingPodcast: null == isLoadingPodcast ? _self.isLoadingPodcast : isLoadingPodcast // ignore: cast_nullable_to_non_nullable
as bool,isGeneratingPodcast: null == isGeneratingPodcast ? _self.isGeneratingPodcast : isGeneratingPodcast // ignore: cast_nullable_to_non_nullable
as bool,questionSets: null == questionSets ? _self._questionSets : questionSets // ignore: cast_nullable_to_non_nullable
as Map<QuestionFormat, List<QuestionSet>>,loadingFormat: freezed == loadingFormat ? _self.loadingFormat : loadingFormat // ignore: cast_nullable_to_non_nullable
as QuestionFormat?,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as Map<int, int>,jobOutputs: null == jobOutputs ? _self._jobOutputs : jobOutputs // ignore: cast_nullable_to_non_nullable
as Map<int, List<String>>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,generationBlocked: null == generationBlocked ? _self.generationBlocked : generationBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyMaterialCopyWith<$Res>? get selectedMaterial {
    if (_self.selectedMaterial == null) {
    return null;
  }

  return $StudyMaterialCopyWith<$Res>(_self.selectedMaterial!, (value) {
    return _then(_self.copyWith(selectedMaterial: value));
  });
}/// Create a copy of StudyToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyPodcastCopyWith<$Res>? get podcast {
    if (_self.podcast == null) {
    return null;
  }

  return $StudyPodcastCopyWith<$Res>(_self.podcast!, (value) {
    return _then(_self.copyWith(podcast: value));
  });
}
}

// dart format on
