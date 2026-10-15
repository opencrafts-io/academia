// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PodcastDto {

 int? get id;@JsonKey(name: 'note_id') int get noteId; String get title;@JsonKey(name: 'generated_at') DateTime get generatedAt;@JsonKey(name: 'duration_seconds') double get durationSeconds;@JsonKey(name: 'audio_url') String get audioUrl; String get script;
/// Create a copy of PodcastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastDtoCopyWith<PodcastDto> get copyWith => _$PodcastDtoCopyWithImpl<PodcastDto>(this as PodcastDto, _$identity);

  /// Serializes this PodcastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PodcastDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.script, _this.script) || other.script == _this.script));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PodcastDto;
  return Object.hash(runtimeType,_this.id,_this.noteId,_this.title,_this.generatedAt,_this.durationSeconds,_this.audioUrl,_this.script);
}

@override
String toString() {
  final _this = this as PodcastDto;
  return 'PodcastDto(id: ${_this.id}, noteId: ${_this.noteId}, title: ${_this.title}, generatedAt: ${_this.generatedAt}, durationSeconds: ${_this.durationSeconds}, audioUrl: ${_this.audioUrl}, script: ${_this.script})';
}


}

/// @nodoc
abstract mixin class $PodcastDtoCopyWith<$Res>  {
  factory $PodcastDtoCopyWith(PodcastDto value, $Res Function(PodcastDto) _then) = _$PodcastDtoCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'note_id') int noteId, String title,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(name: 'duration_seconds') double durationSeconds,@JsonKey(name: 'audio_url') String audioUrl, String script
});




}
/// @nodoc
class _$PodcastDtoCopyWithImpl<$Res>
    implements $PodcastDtoCopyWith<$Res> {
  _$PodcastDtoCopyWithImpl(this._self, this._then);

  final PodcastDto _self;
  final $Res Function(PodcastDto) _then;

/// Create a copy of PodcastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? noteId = null,Object? title = null,Object? generatedAt = null,Object? durationSeconds = null,Object? audioUrl = null,Object? script = null,}) {
  return _then(PodcastDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,script: null == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PodcastDto].
extension PodcastDtoPatterns on PodcastDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PodcastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PodcastDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PodcastDto value)  $default,){
final _that = this;
switch (_that) {
case _PodcastDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PodcastDto value)?  $default,){
final _that = this;
switch (_that) {
case _PodcastDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'note_id')  int noteId,  String title, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'duration_seconds')  double durationSeconds, @JsonKey(name: 'audio_url')  String audioUrl,  String script)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PodcastDto() when $default != null:
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.durationSeconds,_that.audioUrl,_that.script);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'note_id')  int noteId,  String title, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'duration_seconds')  double durationSeconds, @JsonKey(name: 'audio_url')  String audioUrl,  String script)  $default,) {final _that = this;
switch (_that) {
case _PodcastDto():
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.durationSeconds,_that.audioUrl,_that.script);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'note_id')  int noteId,  String title, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'duration_seconds')  double durationSeconds, @JsonKey(name: 'audio_url')  String audioUrl,  String script)?  $default,) {final _that = this;
switch (_that) {
case _PodcastDto() when $default != null:
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.durationSeconds,_that.audioUrl,_that.script);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PodcastDto implements PodcastDto {
  const _PodcastDto({this.id, @JsonKey(name: 'note_id') required this.noteId, this.title = '', @JsonKey(name: 'generated_at') required this.generatedAt, @JsonKey(name: 'duration_seconds') this.durationSeconds = 0, @JsonKey(name: 'audio_url') required this.audioUrl, required this.script});
  factory _PodcastDto.fromJson(Map<String, dynamic> json) => _$PodcastDtoFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'note_id') final  int noteId;
@override@JsonKey() final  String title;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
@override@JsonKey(name: 'duration_seconds') final  double durationSeconds;
@override@JsonKey(name: 'audio_url') final  String audioUrl;
@override final  String script;

/// Create a copy of PodcastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastDtoCopyWith<_PodcastDto> get copyWith => __$PodcastDtoCopyWithImpl<_PodcastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PodcastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PodcastDto&&(identical(other.id, id) || other.id == id)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&(identical(other.title, title) || other.title == title)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.script, script) || other.script == script));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,noteId,title,generatedAt,durationSeconds,audioUrl,script);
}

@override
String toString() {
    return 'PodcastDto(id: $id, noteId: $noteId, title: $title, generatedAt: $generatedAt, durationSeconds: $durationSeconds, audioUrl: $audioUrl, script: $script)';
}


}

/// @nodoc
abstract mixin class _$PodcastDtoCopyWith<$Res> implements $PodcastDtoCopyWith<$Res> {
  factory _$PodcastDtoCopyWith(_PodcastDto value, $Res Function(_PodcastDto) _then) = __$PodcastDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'note_id') int noteId, String title,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(name: 'duration_seconds') double durationSeconds,@JsonKey(name: 'audio_url') String audioUrl, String script
});




}
/// @nodoc
class __$PodcastDtoCopyWithImpl<$Res>
    implements _$PodcastDtoCopyWith<$Res> {
  __$PodcastDtoCopyWithImpl(this._self, this._then);

  final _PodcastDto _self;
  final $Res Function(_PodcastDto) _then;

/// Create a copy of PodcastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? noteId = null,Object? title = null,Object? generatedAt = null,Object? durationSeconds = null,Object? audioUrl = null,Object? script = null,}) {
  return _then(_PodcastDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,script: null == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StudyArtifactsDto {

 bool get summary; Set<QuestionFormat> get questions; bool get podcast;@JsonKey(name: 'study_plans') List<int> get studyPlans;
/// Create a copy of StudyArtifactsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyArtifactsDtoCopyWith<StudyArtifactsDto> get copyWith => _$StudyArtifactsDtoCopyWithImpl<StudyArtifactsDto>(this as StudyArtifactsDto, _$identity);

  /// Serializes this StudyArtifactsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StudyArtifactsDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyArtifactsDto&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.questions, _this.questions)&&(identical(other.podcast, _this.podcast) || other.podcast == _this.podcast)&&const DeepCollectionEquality().equals(other.studyPlans, _this.studyPlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StudyArtifactsDto;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.questions),_this.podcast,const DeepCollectionEquality().hash(_this.studyPlans));
}

@override
String toString() {
  final _this = this as StudyArtifactsDto;
  return 'StudyArtifactsDto(summary: ${_this.summary}, questions: ${_this.questions}, podcast: ${_this.podcast}, studyPlans: ${_this.studyPlans})';
}


}

/// @nodoc
abstract mixin class $StudyArtifactsDtoCopyWith<$Res>  {
  factory $StudyArtifactsDtoCopyWith(StudyArtifactsDto value, $Res Function(StudyArtifactsDto) _then) = _$StudyArtifactsDtoCopyWithImpl;
@useResult
$Res call({
 bool summary, Set<QuestionFormat> questions, bool podcast,@JsonKey(name: 'study_plans') List<int> studyPlans
});




}
/// @nodoc
class _$StudyArtifactsDtoCopyWithImpl<$Res>
    implements $StudyArtifactsDtoCopyWith<$Res> {
  _$StudyArtifactsDtoCopyWithImpl(this._self, this._then);

  final StudyArtifactsDto _self;
  final $Res Function(StudyArtifactsDto) _then;

/// Create a copy of StudyArtifactsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? questions = null,Object? podcast = null,Object? studyPlans = null,}) {
  return _then(StudyArtifactsDto(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as Set<QuestionFormat>,podcast: null == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as bool,studyPlans: null == studyPlans ? _self.studyPlans : studyPlans // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyArtifactsDto].
extension StudyArtifactsDtoPatterns on StudyArtifactsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyArtifactsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyArtifactsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyArtifactsDto value)  $default,){
final _that = this;
switch (_that) {
case _StudyArtifactsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyArtifactsDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudyArtifactsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool summary,  Set<QuestionFormat> questions,  bool podcast, @JsonKey(name: 'study_plans')  List<int> studyPlans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyArtifactsDto() when $default != null:
return $default(_that.summary,_that.questions,_that.podcast,_that.studyPlans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool summary,  Set<QuestionFormat> questions,  bool podcast, @JsonKey(name: 'study_plans')  List<int> studyPlans)  $default,) {final _that = this;
switch (_that) {
case _StudyArtifactsDto():
return $default(_that.summary,_that.questions,_that.podcast,_that.studyPlans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool summary,  Set<QuestionFormat> questions,  bool podcast, @JsonKey(name: 'study_plans')  List<int> studyPlans)?  $default,) {final _that = this;
switch (_that) {
case _StudyArtifactsDto() when $default != null:
return $default(_that.summary,_that.questions,_that.podcast,_that.studyPlans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyArtifactsDto implements StudyArtifactsDto {
  const _StudyArtifactsDto({this.summary = false,  Set<QuestionFormat> questions = const <QuestionFormat>{}, this.podcast = false, @JsonKey(name: 'study_plans')  List<int> studyPlans = const <int>[]}): _questions = questions,_studyPlans = studyPlans;
  factory _StudyArtifactsDto.fromJson(Map<String, dynamic> json) => _$StudyArtifactsDtoFromJson(json);

@override@JsonKey() final  bool summary;
 final  Set<QuestionFormat> _questions;
@override@JsonKey() Set<QuestionFormat> get questions {
  if (_questions is EqualUnmodifiableSetView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_questions);
}

@override@JsonKey() final  bool podcast;
 final  List<int> _studyPlans;
@override@JsonKey(name: 'study_plans') List<int> get studyPlans {
  if (_studyPlans is EqualUnmodifiableListView) return _studyPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studyPlans);
}


/// Create a copy of StudyArtifactsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyArtifactsDtoCopyWith<_StudyArtifactsDto> get copyWith => __$StudyArtifactsDtoCopyWithImpl<_StudyArtifactsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyArtifactsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyArtifactsDto&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.questions, _questions)&&(identical(other.podcast, podcast) || other.podcast == podcast)&&const DeepCollectionEquality().equals(other.studyPlans, _studyPlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_questions),podcast,const DeepCollectionEquality().hash(_studyPlans));
}

@override
String toString() {
    return 'StudyArtifactsDto(summary: $summary, questions: $questions, podcast: $podcast, studyPlans: $studyPlans)';
}


}

/// @nodoc
abstract mixin class _$StudyArtifactsDtoCopyWith<$Res> implements $StudyArtifactsDtoCopyWith<$Res> {
  factory _$StudyArtifactsDtoCopyWith(_StudyArtifactsDto value, $Res Function(_StudyArtifactsDto) _then) = __$StudyArtifactsDtoCopyWithImpl;
@override @useResult
$Res call({
 bool summary, Set<QuestionFormat> questions, bool podcast,@JsonKey(name: 'study_plans') List<int> studyPlans
});




}
/// @nodoc
class __$StudyArtifactsDtoCopyWithImpl<$Res>
    implements _$StudyArtifactsDtoCopyWith<$Res> {
  __$StudyArtifactsDtoCopyWithImpl(this._self, this._then);

  final _StudyArtifactsDto _self;
  final $Res Function(_StudyArtifactsDto) _then;

/// Create a copy of StudyArtifactsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? questions = null,Object? podcast = null,Object? studyPlans = null,}) {
  return _then(_StudyArtifactsDto(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as Set<QuestionFormat>,podcast: null == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as bool,studyPlans: null == studyPlans ? _self._studyPlans : studyPlans // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$StudyMaterialDto {

 int get id;@JsonKey(name: 'course_id') String? get courseId;@JsonKey(name: 'course_label') String get courseLabel;@JsonKey(name: 'original_filename') String get filename;@JsonKey(name: 'size_bytes') int get sizeBytes;@JsonKey(name: 'uploaded_at') DateTime get uploadedAt; StudyArtifactsDto? get artifacts;
/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyMaterialDtoCopyWith<StudyMaterialDto> get copyWith => _$StudyMaterialDtoCopyWithImpl<StudyMaterialDto>(this as StudyMaterialDto, _$identity);

  /// Serializes this StudyMaterialDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StudyMaterialDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyMaterialDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.courseLabel, _this.courseLabel) || other.courseLabel == _this.courseLabel)&&(identical(other.filename, _this.filename) || other.filename == _this.filename)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.uploadedAt, _this.uploadedAt) || other.uploadedAt == _this.uploadedAt)&&(identical(other.artifacts, _this.artifacts) || other.artifacts == _this.artifacts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StudyMaterialDto;
  return Object.hash(runtimeType,_this.id,_this.courseId,_this.courseLabel,_this.filename,_this.sizeBytes,_this.uploadedAt,_this.artifacts);
}

@override
String toString() {
  final _this = this as StudyMaterialDto;
  return 'StudyMaterialDto(id: ${_this.id}, courseId: ${_this.courseId}, courseLabel: ${_this.courseLabel}, filename: ${_this.filename}, sizeBytes: ${_this.sizeBytes}, uploadedAt: ${_this.uploadedAt}, artifacts: ${_this.artifacts})';
}


}

/// @nodoc
abstract mixin class $StudyMaterialDtoCopyWith<$Res>  {
  factory $StudyMaterialDtoCopyWith(StudyMaterialDto value, $Res Function(StudyMaterialDto) _then) = _$StudyMaterialDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'course_id') String? courseId,@JsonKey(name: 'course_label') String courseLabel,@JsonKey(name: 'original_filename') String filename,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'uploaded_at') DateTime uploadedAt, StudyArtifactsDto? artifacts
});


$StudyArtifactsDtoCopyWith<$Res>? get artifacts;

}
/// @nodoc
class _$StudyMaterialDtoCopyWithImpl<$Res>
    implements $StudyMaterialDtoCopyWith<$Res> {
  _$StudyMaterialDtoCopyWithImpl(this._self, this._then);

  final StudyMaterialDto _self;
  final $Res Function(StudyMaterialDto) _then;

/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseId = freezed,Object? courseLabel = null,Object? filename = null,Object? sizeBytes = null,Object? uploadedAt = null,Object? artifacts = freezed,}) {
  return _then(StudyMaterialDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,artifacts: freezed == artifacts ? _self.artifacts : artifacts // ignore: cast_nullable_to_non_nullable
as StudyArtifactsDto?,
  ));
}
/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyArtifactsDtoCopyWith<$Res>? get artifacts {
    if (_self.artifacts == null) {
    return null;
  }

  return $StudyArtifactsDtoCopyWith<$Res>(_self.artifacts!, (value) {
    return _then(_self.copyWith(artifacts: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyMaterialDto].
extension StudyMaterialDtoPatterns on StudyMaterialDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyMaterialDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyMaterialDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyMaterialDto value)  $default,){
final _that = this;
switch (_that) {
case _StudyMaterialDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyMaterialDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudyMaterialDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'course_id')  String? courseId, @JsonKey(name: 'course_label')  String courseLabel, @JsonKey(name: 'original_filename')  String filename, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'uploaded_at')  DateTime uploadedAt,  StudyArtifactsDto? artifacts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyMaterialDto() when $default != null:
return $default(_that.id,_that.courseId,_that.courseLabel,_that.filename,_that.sizeBytes,_that.uploadedAt,_that.artifacts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'course_id')  String? courseId, @JsonKey(name: 'course_label')  String courseLabel, @JsonKey(name: 'original_filename')  String filename, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'uploaded_at')  DateTime uploadedAt,  StudyArtifactsDto? artifacts)  $default,) {final _that = this;
switch (_that) {
case _StudyMaterialDto():
return $default(_that.id,_that.courseId,_that.courseLabel,_that.filename,_that.sizeBytes,_that.uploadedAt,_that.artifacts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'course_id')  String? courseId, @JsonKey(name: 'course_label')  String courseLabel, @JsonKey(name: 'original_filename')  String filename, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'uploaded_at')  DateTime uploadedAt,  StudyArtifactsDto? artifacts)?  $default,) {final _that = this;
switch (_that) {
case _StudyMaterialDto() when $default != null:
return $default(_that.id,_that.courseId,_that.courseLabel,_that.filename,_that.sizeBytes,_that.uploadedAt,_that.artifacts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyMaterialDto implements StudyMaterialDto {
  const _StudyMaterialDto({required this.id, @JsonKey(name: 'course_id') required this.courseId, @JsonKey(name: 'course_label') this.courseLabel = '', @JsonKey(name: 'original_filename') required this.filename, @JsonKey(name: 'size_bytes') required this.sizeBytes, @JsonKey(name: 'uploaded_at') required this.uploadedAt, this.artifacts});
  factory _StudyMaterialDto.fromJson(Map<String, dynamic> json) => _$StudyMaterialDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'course_id') final  String? courseId;
@override@JsonKey(name: 'course_label') final  String courseLabel;
@override@JsonKey(name: 'original_filename') final  String filename;
@override@JsonKey(name: 'size_bytes') final  int sizeBytes;
@override@JsonKey(name: 'uploaded_at') final  DateTime uploadedAt;
@override final  StudyArtifactsDto? artifacts;

/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyMaterialDtoCopyWith<_StudyMaterialDto> get copyWith => __$StudyMaterialDtoCopyWithImpl<_StudyMaterialDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyMaterialDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyMaterialDto&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseLabel, courseLabel) || other.courseLabel == courseLabel)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.artifacts, artifacts) || other.artifacts == artifacts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,courseId,courseLabel,filename,sizeBytes,uploadedAt,artifacts);
}

@override
String toString() {
    return 'StudyMaterialDto(id: $id, courseId: $courseId, courseLabel: $courseLabel, filename: $filename, sizeBytes: $sizeBytes, uploadedAt: $uploadedAt, artifacts: $artifacts)';
}


}

/// @nodoc
abstract mixin class _$StudyMaterialDtoCopyWith<$Res> implements $StudyMaterialDtoCopyWith<$Res> {
  factory _$StudyMaterialDtoCopyWith(_StudyMaterialDto value, $Res Function(_StudyMaterialDto) _then) = __$StudyMaterialDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'course_id') String? courseId,@JsonKey(name: 'course_label') String courseLabel,@JsonKey(name: 'original_filename') String filename,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'uploaded_at') DateTime uploadedAt, StudyArtifactsDto? artifacts
});


@override $StudyArtifactsDtoCopyWith<$Res>? get artifacts;

}
/// @nodoc
class __$StudyMaterialDtoCopyWithImpl<$Res>
    implements _$StudyMaterialDtoCopyWith<$Res> {
  __$StudyMaterialDtoCopyWithImpl(this._self, this._then);

  final _StudyMaterialDto _self;
  final $Res Function(_StudyMaterialDto) _then;

/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseId = freezed,Object? courseLabel = null,Object? filename = null,Object? sizeBytes = null,Object? uploadedAt = null,Object? artifacts = freezed,}) {
  return _then(_StudyMaterialDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,artifacts: freezed == artifacts ? _self.artifacts : artifacts // ignore: cast_nullable_to_non_nullable
as StudyArtifactsDto?,
  ));
}

/// Create a copy of StudyMaterialDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyArtifactsDtoCopyWith<$Res>? get artifacts {
    if (_self.artifacts == null) {
    return null;
  }

  return $StudyArtifactsDtoCopyWith<$Res>(_self.artifacts!, (value) {
    return _then(_self.copyWith(artifacts: value));
  });
}
}


/// @nodoc
mixin _$FlashcardQuestionDto {

 String get front; String get back;
/// Create a copy of FlashcardQuestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardQuestionDtoCopyWith<FlashcardQuestionDto> get copyWith => _$FlashcardQuestionDtoCopyWithImpl<FlashcardQuestionDto>(this as FlashcardQuestionDto, _$identity);

  /// Serializes this FlashcardQuestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FlashcardQuestionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardQuestionDto&&(identical(other.front, _this.front) || other.front == _this.front)&&(identical(other.back, _this.back) || other.back == _this.back));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FlashcardQuestionDto;
  return Object.hash(runtimeType,_this.front,_this.back);
}

@override
String toString() {
  final _this = this as FlashcardQuestionDto;
  return 'FlashcardQuestionDto(front: ${_this.front}, back: ${_this.back})';
}


}

/// @nodoc
abstract mixin class $FlashcardQuestionDtoCopyWith<$Res>  {
  factory $FlashcardQuestionDtoCopyWith(FlashcardQuestionDto value, $Res Function(FlashcardQuestionDto) _then) = _$FlashcardQuestionDtoCopyWithImpl;
@useResult
$Res call({
 String front, String back
});




}
/// @nodoc
class _$FlashcardQuestionDtoCopyWithImpl<$Res>
    implements $FlashcardQuestionDtoCopyWith<$Res> {
  _$FlashcardQuestionDtoCopyWithImpl(this._self, this._then);

  final FlashcardQuestionDto _self;
  final $Res Function(FlashcardQuestionDto) _then;

/// Create a copy of FlashcardQuestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? front = null,Object? back = null,}) {
  return _then(FlashcardQuestionDto(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashcardQuestionDto].
extension FlashcardQuestionDtoPatterns on FlashcardQuestionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashcardQuestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashcardQuestionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashcardQuestionDto value)  $default,){
final _that = this;
switch (_that) {
case _FlashcardQuestionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashcardQuestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _FlashcardQuestionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String front,  String back)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashcardQuestionDto() when $default != null:
return $default(_that.front,_that.back);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String front,  String back)  $default,) {final _that = this;
switch (_that) {
case _FlashcardQuestionDto():
return $default(_that.front,_that.back);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String front,  String back)?  $default,) {final _that = this;
switch (_that) {
case _FlashcardQuestionDto() when $default != null:
return $default(_that.front,_that.back);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashcardQuestionDto implements FlashcardQuestionDto {
  const _FlashcardQuestionDto({required this.front, required this.back});
  factory _FlashcardQuestionDto.fromJson(Map<String, dynamic> json) => _$FlashcardQuestionDtoFromJson(json);

@override final  String front;
@override final  String back;

/// Create a copy of FlashcardQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardQuestionDtoCopyWith<_FlashcardQuestionDto> get copyWith => __$FlashcardQuestionDtoCopyWithImpl<_FlashcardQuestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashcardQuestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardQuestionDto&&(identical(other.front, front) || other.front == front)&&(identical(other.back, back) || other.back == back));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,front,back);
}

@override
String toString() {
    return 'FlashcardQuestionDto(front: $front, back: $back)';
}


}

/// @nodoc
abstract mixin class _$FlashcardQuestionDtoCopyWith<$Res> implements $FlashcardQuestionDtoCopyWith<$Res> {
  factory _$FlashcardQuestionDtoCopyWith(_FlashcardQuestionDto value, $Res Function(_FlashcardQuestionDto) _then) = __$FlashcardQuestionDtoCopyWithImpl;
@override @useResult
$Res call({
 String front, String back
});




}
/// @nodoc
class __$FlashcardQuestionDtoCopyWithImpl<$Res>
    implements _$FlashcardQuestionDtoCopyWith<$Res> {
  __$FlashcardQuestionDtoCopyWithImpl(this._self, this._then);

  final _FlashcardQuestionDto _self;
  final $Res Function(_FlashcardQuestionDto) _then;

/// Create a copy of FlashcardQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? front = null,Object? back = null,}) {
  return _then(_FlashcardQuestionDto(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MultipleChoiceQuestionDto {

 String get question; List<String> get choices;@JsonKey(name: 'answer_index') int get answerIndex; String get explanation;
/// Create a copy of MultipleChoiceQuestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleChoiceQuestionDtoCopyWith<MultipleChoiceQuestionDto> get copyWith => _$MultipleChoiceQuestionDtoCopyWithImpl<MultipleChoiceQuestionDto>(this as MultipleChoiceQuestionDto, _$identity);

  /// Serializes this MultipleChoiceQuestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MultipleChoiceQuestionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleChoiceQuestionDto&&(identical(other.question, _this.question) || other.question == _this.question)&&const DeepCollectionEquality().equals(other.choices, _this.choices)&&(identical(other.answerIndex, _this.answerIndex) || other.answerIndex == _this.answerIndex)&&(identical(other.explanation, _this.explanation) || other.explanation == _this.explanation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MultipleChoiceQuestionDto;
  return Object.hash(runtimeType,_this.question,const DeepCollectionEquality().hash(_this.choices),_this.answerIndex,_this.explanation);
}

@override
String toString() {
  final _this = this as MultipleChoiceQuestionDto;
  return 'MultipleChoiceQuestionDto(question: ${_this.question}, choices: ${_this.choices}, answerIndex: ${_this.answerIndex}, explanation: ${_this.explanation})';
}


}

/// @nodoc
abstract mixin class $MultipleChoiceQuestionDtoCopyWith<$Res>  {
  factory $MultipleChoiceQuestionDtoCopyWith(MultipleChoiceQuestionDto value, $Res Function(MultipleChoiceQuestionDto) _then) = _$MultipleChoiceQuestionDtoCopyWithImpl;
@useResult
$Res call({
 String question, List<String> choices,@JsonKey(name: 'answer_index') int answerIndex, String explanation
});




}
/// @nodoc
class _$MultipleChoiceQuestionDtoCopyWithImpl<$Res>
    implements $MultipleChoiceQuestionDtoCopyWith<$Res> {
  _$MultipleChoiceQuestionDtoCopyWithImpl(this._self, this._then);

  final MultipleChoiceQuestionDto _self;
  final $Res Function(MultipleChoiceQuestionDto) _then;

/// Create a copy of MultipleChoiceQuestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? choices = null,Object? answerIndex = null,Object? explanation = null,}) {
  return _then(MultipleChoiceQuestionDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MultipleChoiceQuestionDto].
extension MultipleChoiceQuestionDtoPatterns on MultipleChoiceQuestionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MultipleChoiceQuestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MultipleChoiceQuestionDto value)  $default,){
final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MultipleChoiceQuestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  List<String> choices, @JsonKey(name: 'answer_index')  int answerIndex,  String explanation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto() when $default != null:
return $default(_that.question,_that.choices,_that.answerIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  List<String> choices, @JsonKey(name: 'answer_index')  int answerIndex,  String explanation)  $default,) {final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto():
return $default(_that.question,_that.choices,_that.answerIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  List<String> choices, @JsonKey(name: 'answer_index')  int answerIndex,  String explanation)?  $default,) {final _that = this;
switch (_that) {
case _MultipleChoiceQuestionDto() when $default != null:
return $default(_that.question,_that.choices,_that.answerIndex,_that.explanation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MultipleChoiceQuestionDto implements MultipleChoiceQuestionDto {
  const _MultipleChoiceQuestionDto({required this.question, required  List<String> choices, @JsonKey(name: 'answer_index') required this.answerIndex, this.explanation = ''}): _choices = choices;
  factory _MultipleChoiceQuestionDto.fromJson(Map<String, dynamic> json) => _$MultipleChoiceQuestionDtoFromJson(json);

@override final  String question;
 final  List<String> _choices;
@override List<String> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

@override@JsonKey(name: 'answer_index') final  int answerIndex;
@override@JsonKey() final  String explanation;

/// Create a copy of MultipleChoiceQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MultipleChoiceQuestionDtoCopyWith<_MultipleChoiceQuestionDto> get copyWith => __$MultipleChoiceQuestionDtoCopyWithImpl<_MultipleChoiceQuestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MultipleChoiceQuestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MultipleChoiceQuestionDto&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.choices, _choices)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_choices),answerIndex,explanation);
}

@override
String toString() {
    return 'MultipleChoiceQuestionDto(question: $question, choices: $choices, answerIndex: $answerIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class _$MultipleChoiceQuestionDtoCopyWith<$Res> implements $MultipleChoiceQuestionDtoCopyWith<$Res> {
  factory _$MultipleChoiceQuestionDtoCopyWith(_MultipleChoiceQuestionDto value, $Res Function(_MultipleChoiceQuestionDto) _then) = __$MultipleChoiceQuestionDtoCopyWithImpl;
@override @useResult
$Res call({
 String question, List<String> choices,@JsonKey(name: 'answer_index') int answerIndex, String explanation
});




}
/// @nodoc
class __$MultipleChoiceQuestionDtoCopyWithImpl<$Res>
    implements _$MultipleChoiceQuestionDtoCopyWith<$Res> {
  __$MultipleChoiceQuestionDtoCopyWithImpl(this._self, this._then);

  final _MultipleChoiceQuestionDto _self;
  final $Res Function(_MultipleChoiceQuestionDto) _then;

/// Create a copy of MultipleChoiceQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? choices = null,Object? answerIndex = null,Object? explanation = null,}) {
  return _then(_MultipleChoiceQuestionDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OpenEndedQuestionDto {

 String get question;@JsonKey(name: 'model_answer') String get modelAnswer;
/// Create a copy of OpenEndedQuestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenEndedQuestionDtoCopyWith<OpenEndedQuestionDto> get copyWith => _$OpenEndedQuestionDtoCopyWithImpl<OpenEndedQuestionDto>(this as OpenEndedQuestionDto, _$identity);

  /// Serializes this OpenEndedQuestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OpenEndedQuestionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenEndedQuestionDto&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.modelAnswer, _this.modelAnswer) || other.modelAnswer == _this.modelAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OpenEndedQuestionDto;
  return Object.hash(runtimeType,_this.question,_this.modelAnswer);
}

@override
String toString() {
  final _this = this as OpenEndedQuestionDto;
  return 'OpenEndedQuestionDto(question: ${_this.question}, modelAnswer: ${_this.modelAnswer})';
}


}

/// @nodoc
abstract mixin class $OpenEndedQuestionDtoCopyWith<$Res>  {
  factory $OpenEndedQuestionDtoCopyWith(OpenEndedQuestionDto value, $Res Function(OpenEndedQuestionDto) _then) = _$OpenEndedQuestionDtoCopyWithImpl;
@useResult
$Res call({
 String question,@JsonKey(name: 'model_answer') String modelAnswer
});




}
/// @nodoc
class _$OpenEndedQuestionDtoCopyWithImpl<$Res>
    implements $OpenEndedQuestionDtoCopyWith<$Res> {
  _$OpenEndedQuestionDtoCopyWithImpl(this._self, this._then);

  final OpenEndedQuestionDto _self;
  final $Res Function(OpenEndedQuestionDto) _then;

/// Create a copy of OpenEndedQuestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? modelAnswer = null,}) {
  return _then(OpenEndedQuestionDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,modelAnswer: null == modelAnswer ? _self.modelAnswer : modelAnswer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenEndedQuestionDto].
extension OpenEndedQuestionDtoPatterns on OpenEndedQuestionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenEndedQuestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenEndedQuestionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenEndedQuestionDto value)  $default,){
final _that = this;
switch (_that) {
case _OpenEndedQuestionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenEndedQuestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _OpenEndedQuestionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question, @JsonKey(name: 'model_answer')  String modelAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenEndedQuestionDto() when $default != null:
return $default(_that.question,_that.modelAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question, @JsonKey(name: 'model_answer')  String modelAnswer)  $default,) {final _that = this;
switch (_that) {
case _OpenEndedQuestionDto():
return $default(_that.question,_that.modelAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question, @JsonKey(name: 'model_answer')  String modelAnswer)?  $default,) {final _that = this;
switch (_that) {
case _OpenEndedQuestionDto() when $default != null:
return $default(_that.question,_that.modelAnswer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenEndedQuestionDto implements OpenEndedQuestionDto {
  const _OpenEndedQuestionDto({required this.question, @JsonKey(name: 'model_answer') required this.modelAnswer});
  factory _OpenEndedQuestionDto.fromJson(Map<String, dynamic> json) => _$OpenEndedQuestionDtoFromJson(json);

@override final  String question;
@override@JsonKey(name: 'model_answer') final  String modelAnswer;

/// Create a copy of OpenEndedQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenEndedQuestionDtoCopyWith<_OpenEndedQuestionDto> get copyWith => __$OpenEndedQuestionDtoCopyWithImpl<_OpenEndedQuestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenEndedQuestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenEndedQuestionDto&&(identical(other.question, question) || other.question == question)&&(identical(other.modelAnswer, modelAnswer) || other.modelAnswer == modelAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,question,modelAnswer);
}

@override
String toString() {
    return 'OpenEndedQuestionDto(question: $question, modelAnswer: $modelAnswer)';
}


}

/// @nodoc
abstract mixin class _$OpenEndedQuestionDtoCopyWith<$Res> implements $OpenEndedQuestionDtoCopyWith<$Res> {
  factory _$OpenEndedQuestionDtoCopyWith(_OpenEndedQuestionDto value, $Res Function(_OpenEndedQuestionDto) _then) = __$OpenEndedQuestionDtoCopyWithImpl;
@override @useResult
$Res call({
 String question,@JsonKey(name: 'model_answer') String modelAnswer
});




}
/// @nodoc
class __$OpenEndedQuestionDtoCopyWithImpl<$Res>
    implements _$OpenEndedQuestionDtoCopyWith<$Res> {
  __$OpenEndedQuestionDtoCopyWithImpl(this._self, this._then);

  final _OpenEndedQuestionDto _self;
  final $Res Function(_OpenEndedQuestionDto) _then;

/// Create a copy of OpenEndedQuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? modelAnswer = null,}) {
  return _then(_OpenEndedQuestionDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,modelAnswer: null == modelAnswer ? _self.modelAnswer : modelAnswer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$QuestionSetDto {

 int get id; QuestionFormat get format;@JsonKey(name: 'generated_at') DateTime get generatedAt;@JsonKey(includeFromJson: false, includeToJson: false) List<StudyQuestion> get questions;
/// Create a copy of QuestionSetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSetDtoCopyWith<QuestionSetDto> get copyWith => _$QuestionSetDtoCopyWithImpl<QuestionSetDto>(this as QuestionSetDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuestionSetDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSetDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&const DeepCollectionEquality().equals(other.questions, _this.questions));
}


@override
int get hashCode {
  final _this = this as QuestionSetDto;
  return Object.hash(runtimeType,_this.id,_this.format,_this.generatedAt,const DeepCollectionEquality().hash(_this.questions));
}

@override
String toString() {
  final _this = this as QuestionSetDto;
  return 'QuestionSetDto(id: ${_this.id}, format: ${_this.format}, generatedAt: ${_this.generatedAt}, questions: ${_this.questions})';
}


}

/// @nodoc
abstract mixin class $QuestionSetDtoCopyWith<$Res>  {
  factory $QuestionSetDtoCopyWith(QuestionSetDto value, $Res Function(QuestionSetDto) _then) = _$QuestionSetDtoCopyWithImpl;
@useResult
$Res call({
 int id, QuestionFormat format,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(includeFromJson: false, includeToJson: false) List<StudyQuestion> questions
});




}
/// @nodoc
class _$QuestionSetDtoCopyWithImpl<$Res>
    implements $QuestionSetDtoCopyWith<$Res> {
  _$QuestionSetDtoCopyWithImpl(this._self, this._then);

  final QuestionSetDto _self;
  final $Res Function(QuestionSetDto) _then;

/// Create a copy of QuestionSetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? format = null,Object? generatedAt = null,Object? questions = null,}) {
  return _then(QuestionSetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as QuestionFormat,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<StudyQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionSetDto].
extension QuestionSetDtoPatterns on QuestionSetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSetDto value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSetDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  QuestionFormat format, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<StudyQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSetDto() when $default != null:
return $default(_that.id,_that.format,_that.generatedAt,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  QuestionFormat format, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<StudyQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _QuestionSetDto():
return $default(_that.id,_that.format,_that.generatedAt,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  QuestionFormat format, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<StudyQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSetDto() when $default != null:
return $default(_that.id,_that.format,_that.generatedAt,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionSetDto implements QuestionSetDto {
  const _QuestionSetDto({required this.id, required this.format, @JsonKey(name: 'generated_at') required this.generatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  List<StudyQuestion> questions = const <StudyQuestion>[]}): _questions = questions;
  

@override final  int id;
@override final  QuestionFormat format;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
 final  List<StudyQuestion> _questions;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<StudyQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuestionSetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSetDtoCopyWith<_QuestionSetDto> get copyWith => __$QuestionSetDtoCopyWithImpl<_QuestionSetDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.format, format) || other.format == format)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other.questions, _questions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,format,generatedAt,const DeepCollectionEquality().hash(_questions));
}

@override
String toString() {
    return 'QuestionSetDto(id: $id, format: $format, generatedAt: $generatedAt, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuestionSetDtoCopyWith<$Res> implements $QuestionSetDtoCopyWith<$Res> {
  factory _$QuestionSetDtoCopyWith(_QuestionSetDto value, $Res Function(_QuestionSetDto) _then) = __$QuestionSetDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, QuestionFormat format,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(includeFromJson: false, includeToJson: false) List<StudyQuestion> questions
});




}
/// @nodoc
class __$QuestionSetDtoCopyWithImpl<$Res>
    implements _$QuestionSetDtoCopyWith<$Res> {
  __$QuestionSetDtoCopyWithImpl(this._self, this._then);

  final _QuestionSetDto _self;
  final $Res Function(_QuestionSetDto) _then;

/// Create a copy of QuestionSetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? format = null,Object? generatedAt = null,Object? questions = null,}) {
  return _then(_QuestionSetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as QuestionFormat,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<StudyQuestion>,
  ));
}


}


/// @nodoc
mixin _$GenerationJobDto {

 int get id;@JsonKey(name: 'note_id') int? get noteId; List<String> get outputs; String get status;@JsonKey(name: 'failure_code') String? get failureCode;@JsonKey(name: 'failure_message') String? get failureMessage;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'finished_at') DateTime? get finishedAt;
/// Create a copy of GenerationJobDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationJobDtoCopyWith<GenerationJobDto> get copyWith => _$GenerationJobDtoCopyWithImpl<GenerationJobDto>(this as GenerationJobDto, _$identity);

  /// Serializes this GenerationJobDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GenerationJobDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationJobDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&const DeepCollectionEquality().equals(other.outputs, _this.outputs)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.failureCode, _this.failureCode) || other.failureCode == _this.failureCode)&&(identical(other.failureMessage, _this.failureMessage) || other.failureMessage == _this.failureMessage)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.finishedAt, _this.finishedAt) || other.finishedAt == _this.finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GenerationJobDto;
  return Object.hash(runtimeType,_this.id,_this.noteId,const DeepCollectionEquality().hash(_this.outputs),_this.status,_this.failureCode,_this.failureMessage,_this.createdAt,_this.finishedAt);
}

@override
String toString() {
  final _this = this as GenerationJobDto;
  return 'GenerationJobDto(id: ${_this.id}, noteId: ${_this.noteId}, outputs: ${_this.outputs}, status: ${_this.status}, failureCode: ${_this.failureCode}, failureMessage: ${_this.failureMessage}, createdAt: ${_this.createdAt}, finishedAt: ${_this.finishedAt})';
}


}

/// @nodoc
abstract mixin class $GenerationJobDtoCopyWith<$Res>  {
  factory $GenerationJobDtoCopyWith(GenerationJobDto value, $Res Function(GenerationJobDto) _then) = _$GenerationJobDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'note_id') int? noteId, List<String> outputs, String status,@JsonKey(name: 'failure_code') String? failureCode,@JsonKey(name: 'failure_message') String? failureMessage,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'finished_at') DateTime? finishedAt
});




}
/// @nodoc
class _$GenerationJobDtoCopyWithImpl<$Res>
    implements $GenerationJobDtoCopyWith<$Res> {
  _$GenerationJobDtoCopyWithImpl(this._self, this._then);

  final GenerationJobDto _self;
  final $Res Function(GenerationJobDto) _then;

/// Create a copy of GenerationJobDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? noteId = freezed,Object? outputs = null,Object? status = null,Object? failureCode = freezed,Object? failureMessage = freezed,Object? createdAt = null,Object? finishedAt = freezed,}) {
  return _then(GenerationJobDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,noteId: freezed == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int?,outputs: null == outputs ? _self.outputs : outputs // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,failureCode: freezed == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String?,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerationJobDto].
extension GenerationJobDtoPatterns on GenerationJobDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationJobDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationJobDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationJobDto value)  $default,){
final _that = this;
switch (_that) {
case _GenerationJobDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationJobDto value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationJobDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'note_id')  int? noteId,  List<String> outputs,  String status, @JsonKey(name: 'failure_code')  String? failureCode, @JsonKey(name: 'failure_message')  String? failureMessage, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'finished_at')  DateTime? finishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationJobDto() when $default != null:
return $default(_that.id,_that.noteId,_that.outputs,_that.status,_that.failureCode,_that.failureMessage,_that.createdAt,_that.finishedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'note_id')  int? noteId,  List<String> outputs,  String status, @JsonKey(name: 'failure_code')  String? failureCode, @JsonKey(name: 'failure_message')  String? failureMessage, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'finished_at')  DateTime? finishedAt)  $default,) {final _that = this;
switch (_that) {
case _GenerationJobDto():
return $default(_that.id,_that.noteId,_that.outputs,_that.status,_that.failureCode,_that.failureMessage,_that.createdAt,_that.finishedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'note_id')  int? noteId,  List<String> outputs,  String status, @JsonKey(name: 'failure_code')  String? failureCode, @JsonKey(name: 'failure_message')  String? failureMessage, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'finished_at')  DateTime? finishedAt)?  $default,) {final _that = this;
switch (_that) {
case _GenerationJobDto() when $default != null:
return $default(_that.id,_that.noteId,_that.outputs,_that.status,_that.failureCode,_that.failureMessage,_that.createdAt,_that.finishedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerationJobDto implements GenerationJobDto {
  const _GenerationJobDto({required this.id, @JsonKey(name: 'note_id') required this.noteId, required  List<String> outputs, required this.status, @JsonKey(name: 'failure_code') required this.failureCode, @JsonKey(name: 'failure_message') required this.failureMessage, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'finished_at') required this.finishedAt}): _outputs = outputs;
  factory _GenerationJobDto.fromJson(Map<String, dynamic> json) => _$GenerationJobDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'note_id') final  int? noteId;
 final  List<String> _outputs;
@override List<String> get outputs {
  if (_outputs is EqualUnmodifiableListView) return _outputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outputs);
}

@override final  String status;
@override@JsonKey(name: 'failure_code') final  String? failureCode;
@override@JsonKey(name: 'failure_message') final  String? failureMessage;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'finished_at') final  DateTime? finishedAt;

/// Create a copy of GenerationJobDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationJobDtoCopyWith<_GenerationJobDto> get copyWith => __$GenerationJobDtoCopyWithImpl<_GenerationJobDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerationJobDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationJobDto&&(identical(other.id, id) || other.id == id)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&const DeepCollectionEquality().equals(other.outputs, _outputs)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,noteId,const DeepCollectionEquality().hash(_outputs),status,failureCode,failureMessage,createdAt,finishedAt);
}

@override
String toString() {
    return 'GenerationJobDto(id: $id, noteId: $noteId, outputs: $outputs, status: $status, failureCode: $failureCode, failureMessage: $failureMessage, createdAt: $createdAt, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class _$GenerationJobDtoCopyWith<$Res> implements $GenerationJobDtoCopyWith<$Res> {
  factory _$GenerationJobDtoCopyWith(_GenerationJobDto value, $Res Function(_GenerationJobDto) _then) = __$GenerationJobDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'note_id') int? noteId, List<String> outputs, String status,@JsonKey(name: 'failure_code') String? failureCode,@JsonKey(name: 'failure_message') String? failureMessage,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'finished_at') DateTime? finishedAt
});




}
/// @nodoc
class __$GenerationJobDtoCopyWithImpl<$Res>
    implements _$GenerationJobDtoCopyWith<$Res> {
  __$GenerationJobDtoCopyWithImpl(this._self, this._then);

  final _GenerationJobDto _self;
  final $Res Function(_GenerationJobDto) _then;

/// Create a copy of GenerationJobDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? noteId = freezed,Object? outputs = null,Object? status = null,Object? failureCode = freezed,Object? failureMessage = freezed,Object? createdAt = null,Object? finishedAt = freezed,}) {
  return _then(_GenerationJobDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,noteId: freezed == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int?,outputs: null == outputs ? _self._outputs : outputs // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,failureCode: freezed == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String?,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
