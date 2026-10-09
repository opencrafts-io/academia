// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyCourseOption {

 String get id; String get title; String? get professorId;
/// Create a copy of StudyCourseOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyCourseOptionCopyWith<StudyCourseOption> get copyWith => _$StudyCourseOptionCopyWithImpl<StudyCourseOption>(this as StudyCourseOption, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyCourseOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyCourseOption&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.professorId, _this.professorId) || other.professorId == _this.professorId));
}


@override
int get hashCode {
  final _this = this as StudyCourseOption;
  return Object.hash(runtimeType,_this.id,_this.title,_this.professorId);
}

@override
String toString() {
  final _this = this as StudyCourseOption;
  return 'StudyCourseOption(id: ${_this.id}, title: ${_this.title}, professorId: ${_this.professorId})';
}


}

/// @nodoc
abstract mixin class $StudyCourseOptionCopyWith<$Res>  {
  factory $StudyCourseOptionCopyWith(StudyCourseOption value, $Res Function(StudyCourseOption) _then) = _$StudyCourseOptionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? professorId
});




}
/// @nodoc
class _$StudyCourseOptionCopyWithImpl<$Res>
    implements $StudyCourseOptionCopyWith<$Res> {
  _$StudyCourseOptionCopyWithImpl(this._self, this._then);

  final StudyCourseOption _self;
  final $Res Function(StudyCourseOption) _then;

/// Create a copy of StudyCourseOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? professorId = freezed,}) {
  return _then(StudyCourseOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,professorId: freezed == professorId ? _self.professorId : professorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyCourseOption].
extension StudyCourseOptionPatterns on StudyCourseOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyCourseOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyCourseOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyCourseOption value)  $default,){
final _that = this;
switch (_that) {
case _StudyCourseOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyCourseOption value)?  $default,){
final _that = this;
switch (_that) {
case _StudyCourseOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? professorId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyCourseOption() when $default != null:
return $default(_that.id,_that.title,_that.professorId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? professorId)  $default,) {final _that = this;
switch (_that) {
case _StudyCourseOption():
return $default(_that.id,_that.title,_that.professorId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? professorId)?  $default,) {final _that = this;
switch (_that) {
case _StudyCourseOption() when $default != null:
return $default(_that.id,_that.title,_that.professorId);case _:
  return null;

}
}

}

/// @nodoc


class _StudyCourseOption implements StudyCourseOption {
  const _StudyCourseOption({required this.id, required this.title, this.professorId});


@override final  String id;
@override final  String title;
@override final  String? professorId;

/// Create a copy of StudyCourseOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyCourseOptionCopyWith<_StudyCourseOption> get copyWith => __$StudyCourseOptionCopyWithImpl<_StudyCourseOption>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyCourseOption&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.professorId, professorId) || other.professorId == professorId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,professorId);
}

@override
String toString() {
    return 'StudyCourseOption(id: $id, title: $title, professorId: $professorId)';
}


}

/// @nodoc
abstract mixin class _$StudyCourseOptionCopyWith<$Res> implements $StudyCourseOptionCopyWith<$Res> {
  factory _$StudyCourseOptionCopyWith(_StudyCourseOption value, $Res Function(_StudyCourseOption) _then) = __$StudyCourseOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? professorId
});




}
/// @nodoc
class __$StudyCourseOptionCopyWithImpl<$Res>
    implements _$StudyCourseOptionCopyWith<$Res> {
  __$StudyCourseOptionCopyWithImpl(this._self, this._then);

  final _StudyCourseOption _self;
  final $Res Function(_StudyCourseOption) _then;

/// Create a copy of StudyCourseOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? professorId = freezed,}) {
  return _then(_StudyCourseOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,professorId: freezed == professorId ? _self.professorId : professorId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$StudyMaterial {

 int get id; String? get courseId; String get courseLabel; String get filename; int get sizeBytes; DateTime get uploadedAt; StudyArtifacts? get artifacts;
/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyMaterialCopyWith<StudyMaterial> get copyWith => _$StudyMaterialCopyWithImpl<StudyMaterial>(this as StudyMaterial, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyMaterial;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyMaterial&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.courseLabel, _this.courseLabel) || other.courseLabel == _this.courseLabel)&&(identical(other.filename, _this.filename) || other.filename == _this.filename)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.uploadedAt, _this.uploadedAt) || other.uploadedAt == _this.uploadedAt)&&(identical(other.artifacts, _this.artifacts) || other.artifacts == _this.artifacts));
}


@override
int get hashCode {
  final _this = this as StudyMaterial;
  return Object.hash(runtimeType,_this.id,_this.courseId,_this.courseLabel,_this.filename,_this.sizeBytes,_this.uploadedAt,_this.artifacts);
}

@override
String toString() {
  final _this = this as StudyMaterial;
  return 'StudyMaterial(id: ${_this.id}, courseId: ${_this.courseId}, courseLabel: ${_this.courseLabel}, filename: ${_this.filename}, sizeBytes: ${_this.sizeBytes}, uploadedAt: ${_this.uploadedAt}, artifacts: ${_this.artifacts})';
}


}

/// @nodoc
abstract mixin class $StudyMaterialCopyWith<$Res>  {
  factory $StudyMaterialCopyWith(StudyMaterial value, $Res Function(StudyMaterial) _then) = _$StudyMaterialCopyWithImpl;
@useResult
$Res call({
 int id, String? courseId, String courseLabel, String filename, int sizeBytes, DateTime uploadedAt, StudyArtifacts? artifacts
});


$StudyArtifactsCopyWith<$Res>? get artifacts;

}
/// @nodoc
class _$StudyMaterialCopyWithImpl<$Res>
    implements $StudyMaterialCopyWith<$Res> {
  _$StudyMaterialCopyWithImpl(this._self, this._then);

  final StudyMaterial _self;
  final $Res Function(StudyMaterial) _then;

/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseId = freezed,Object? courseLabel = null,Object? filename = null,Object? sizeBytes = null,Object? uploadedAt = null,Object? artifacts = freezed,}) {
  return _then(StudyMaterial(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,artifacts: freezed == artifacts ? _self.artifacts : artifacts // ignore: cast_nullable_to_non_nullable
as StudyArtifacts?,
  ));
}
/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyArtifactsCopyWith<$Res>? get artifacts {
    if (_self.artifacts == null) {
    return null;
  }

  return $StudyArtifactsCopyWith<$Res>(_self.artifacts!, (value) {
    return _then(_self.copyWith(artifacts: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyMaterial].
extension StudyMaterialPatterns on StudyMaterial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyMaterial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyMaterial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyMaterial value)  $default,){
final _that = this;
switch (_that) {
case _StudyMaterial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyMaterial value)?  $default,){
final _that = this;
switch (_that) {
case _StudyMaterial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? courseId,  String courseLabel,  String filename,  int sizeBytes,  DateTime uploadedAt,  StudyArtifacts? artifacts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyMaterial() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? courseId,  String courseLabel,  String filename,  int sizeBytes,  DateTime uploadedAt,  StudyArtifacts? artifacts)  $default,) {final _that = this;
switch (_that) {
case _StudyMaterial():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? courseId,  String courseLabel,  String filename,  int sizeBytes,  DateTime uploadedAt,  StudyArtifacts? artifacts)?  $default,) {final _that = this;
switch (_that) {
case _StudyMaterial() when $default != null:
return $default(_that.id,_that.courseId,_that.courseLabel,_that.filename,_that.sizeBytes,_that.uploadedAt,_that.artifacts);case _:
  return null;

}
}

}

/// @nodoc


class _StudyMaterial implements StudyMaterial {
  const _StudyMaterial({required this.id, required this.courseId, required this.courseLabel, required this.filename, required this.sizeBytes, required this.uploadedAt, this.artifacts});


@override final  int id;
@override final  String? courseId;
@override final  String courseLabel;
@override final  String filename;
@override final  int sizeBytes;
@override final  DateTime uploadedAt;
@override final  StudyArtifacts? artifacts;

/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyMaterialCopyWith<_StudyMaterial> get copyWith => __$StudyMaterialCopyWithImpl<_StudyMaterial>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyMaterial&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseLabel, courseLabel) || other.courseLabel == courseLabel)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.artifacts, artifacts) || other.artifacts == artifacts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,courseId,courseLabel,filename,sizeBytes,uploadedAt,artifacts);
}

@override
String toString() {
    return 'StudyMaterial(id: $id, courseId: $courseId, courseLabel: $courseLabel, filename: $filename, sizeBytes: $sizeBytes, uploadedAt: $uploadedAt, artifacts: $artifacts)';
}


}

/// @nodoc
abstract mixin class _$StudyMaterialCopyWith<$Res> implements $StudyMaterialCopyWith<$Res> {
  factory _$StudyMaterialCopyWith(_StudyMaterial value, $Res Function(_StudyMaterial) _then) = __$StudyMaterialCopyWithImpl;
@override @useResult
$Res call({
 int id, String? courseId, String courseLabel, String filename, int sizeBytes, DateTime uploadedAt, StudyArtifacts? artifacts
});


@override $StudyArtifactsCopyWith<$Res>? get artifacts;

}
/// @nodoc
class __$StudyMaterialCopyWithImpl<$Res>
    implements _$StudyMaterialCopyWith<$Res> {
  __$StudyMaterialCopyWithImpl(this._self, this._then);

  final _StudyMaterial _self;
  final $Res Function(_StudyMaterial) _then;

/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseId = freezed,Object? courseLabel = null,Object? filename = null,Object? sizeBytes = null,Object? uploadedAt = null,Object? artifacts = freezed,}) {
  return _then(_StudyMaterial(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,artifacts: freezed == artifacts ? _self.artifacts : artifacts // ignore: cast_nullable_to_non_nullable
as StudyArtifacts?,
  ));
}

/// Create a copy of StudyMaterial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyArtifactsCopyWith<$Res>? get artifacts {
    if (_self.artifacts == null) {
    return null;
  }

  return $StudyArtifactsCopyWith<$Res>(_self.artifacts!, (value) {
    return _then(_self.copyWith(artifacts: value));
  });
}
}

/// @nodoc
mixin _$StudyArtifacts {

 bool get summary; Set<QuestionFormat> get questions; bool get podcast; List<int> get studyPlans;
/// Create a copy of StudyArtifacts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyArtifactsCopyWith<StudyArtifacts> get copyWith => _$StudyArtifactsCopyWithImpl<StudyArtifacts>(this as StudyArtifacts, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyArtifacts;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyArtifacts&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.questions, _this.questions)&&(identical(other.podcast, _this.podcast) || other.podcast == _this.podcast)&&const DeepCollectionEquality().equals(other.studyPlans, _this.studyPlans));
}


@override
int get hashCode {
  final _this = this as StudyArtifacts;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.questions),_this.podcast,const DeepCollectionEquality().hash(_this.studyPlans));
}

@override
String toString() {
  final _this = this as StudyArtifacts;
  return 'StudyArtifacts(summary: ${_this.summary}, questions: ${_this.questions}, podcast: ${_this.podcast}, studyPlans: ${_this.studyPlans})';
}


}

/// @nodoc
abstract mixin class $StudyArtifactsCopyWith<$Res>  {
  factory $StudyArtifactsCopyWith(StudyArtifacts value, $Res Function(StudyArtifacts) _then) = _$StudyArtifactsCopyWithImpl;
@useResult
$Res call({
 bool summary, Set<QuestionFormat> questions, bool podcast, List<int> studyPlans
});




}
/// @nodoc
class _$StudyArtifactsCopyWithImpl<$Res>
    implements $StudyArtifactsCopyWith<$Res> {
  _$StudyArtifactsCopyWithImpl(this._self, this._then);

  final StudyArtifacts _self;
  final $Res Function(StudyArtifacts) _then;

/// Create a copy of StudyArtifacts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? questions = null,Object? podcast = null,Object? studyPlans = null,}) {
  return _then(StudyArtifacts(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as Set<QuestionFormat>,podcast: null == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as bool,studyPlans: null == studyPlans ? _self.studyPlans : studyPlans // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyArtifacts].
extension StudyArtifactsPatterns on StudyArtifacts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyArtifacts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyArtifacts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyArtifacts value)  $default,){
final _that = this;
switch (_that) {
case _StudyArtifacts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyArtifacts value)?  $default,){
final _that = this;
switch (_that) {
case _StudyArtifacts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool summary,  Set<QuestionFormat> questions,  bool podcast,  List<int> studyPlans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyArtifacts() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool summary,  Set<QuestionFormat> questions,  bool podcast,  List<int> studyPlans)  $default,) {final _that = this;
switch (_that) {
case _StudyArtifacts():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool summary,  Set<QuestionFormat> questions,  bool podcast,  List<int> studyPlans)?  $default,) {final _that = this;
switch (_that) {
case _StudyArtifacts() when $default != null:
return $default(_that.summary,_that.questions,_that.podcast,_that.studyPlans);case _:
  return null;

}
}

}

/// @nodoc


class _StudyArtifacts implements StudyArtifacts {
  const _StudyArtifacts({this.summary = false,  Set<QuestionFormat> questions = const <QuestionFormat>{}, this.podcast = false,  List<int> studyPlans = const <int>[]}): _questions = questions,_studyPlans = studyPlans;


@override@JsonKey() final  bool summary;
 final  Set<QuestionFormat> _questions;
@override@JsonKey() Set<QuestionFormat> get questions {
  if (_questions is EqualUnmodifiableSetView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_questions);
}

@override@JsonKey() final  bool podcast;
 final  List<int> _studyPlans;
@override@JsonKey() List<int> get studyPlans {
  if (_studyPlans is EqualUnmodifiableListView) return _studyPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studyPlans);
}


/// Create a copy of StudyArtifacts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyArtifactsCopyWith<_StudyArtifacts> get copyWith => __$StudyArtifactsCopyWithImpl<_StudyArtifacts>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyArtifacts&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.questions, _questions)&&(identical(other.podcast, podcast) || other.podcast == podcast)&&const DeepCollectionEquality().equals(other.studyPlans, _studyPlans));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_questions),podcast,const DeepCollectionEquality().hash(_studyPlans));
}

@override
String toString() {
    return 'StudyArtifacts(summary: $summary, questions: $questions, podcast: $podcast, studyPlans: $studyPlans)';
}


}

/// @nodoc
abstract mixin class _$StudyArtifactsCopyWith<$Res> implements $StudyArtifactsCopyWith<$Res> {
  factory _$StudyArtifactsCopyWith(_StudyArtifacts value, $Res Function(_StudyArtifacts) _then) = __$StudyArtifactsCopyWithImpl;
@override @useResult
$Res call({
 bool summary, Set<QuestionFormat> questions, bool podcast, List<int> studyPlans
});




}
/// @nodoc
class __$StudyArtifactsCopyWithImpl<$Res>
    implements _$StudyArtifactsCopyWith<$Res> {
  __$StudyArtifactsCopyWithImpl(this._self, this._then);

  final _StudyArtifacts _self;
  final $Res Function(_StudyArtifacts) _then;

/// Create a copy of StudyArtifacts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? questions = null,Object? podcast = null,Object? studyPlans = null,}) {
  return _then(_StudyArtifacts(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as Set<QuestionFormat>,podcast: null == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as bool,studyPlans: null == studyPlans ? _self._studyPlans : studyPlans // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$StudyQuestion {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyQuestion);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StudyQuestion()';
}


}

/// @nodoc
class $StudyQuestionCopyWith<$Res>  {
$StudyQuestionCopyWith(StudyQuestion _, $Res Function(StudyQuestion) __);
}


/// Adds pattern-matching-related methods to [StudyQuestion].
extension StudyQuestionPatterns on StudyQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FlashcardQuestion value)?  flashcard,TResult Function( MultipleChoiceQuestion value)?  mcq,TResult Function( OpenEndedQuestion value)?  openEnded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FlashcardQuestion() when flashcard != null:
return flashcard(_that);case MultipleChoiceQuestion() when mcq != null:
return mcq(_that);case OpenEndedQuestion() when openEnded != null:
return openEnded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FlashcardQuestion value)  flashcard,required TResult Function( MultipleChoiceQuestion value)  mcq,required TResult Function( OpenEndedQuestion value)  openEnded,}){
final _that = this;
switch (_that) {
case FlashcardQuestion():
return flashcard(_that);case MultipleChoiceQuestion():
return mcq(_that);case OpenEndedQuestion():
return openEnded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FlashcardQuestion value)?  flashcard,TResult? Function( MultipleChoiceQuestion value)?  mcq,TResult? Function( OpenEndedQuestion value)?  openEnded,}){
final _that = this;
switch (_that) {
case FlashcardQuestion() when flashcard != null:
return flashcard(_that);case MultipleChoiceQuestion() when mcq != null:
return mcq(_that);case OpenEndedQuestion() when openEnded != null:
return openEnded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String front,  String back)?  flashcard,TResult Function( String question,  List<String> choices,  int answerIndex,  String explanation)?  mcq,TResult Function( String question,  String modelAnswer)?  openEnded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FlashcardQuestion() when flashcard != null:
return flashcard(_that.front,_that.back);case MultipleChoiceQuestion() when mcq != null:
return mcq(_that.question,_that.choices,_that.answerIndex,_that.explanation);case OpenEndedQuestion() when openEnded != null:
return openEnded(_that.question,_that.modelAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String front,  String back)  flashcard,required TResult Function( String question,  List<String> choices,  int answerIndex,  String explanation)  mcq,required TResult Function( String question,  String modelAnswer)  openEnded,}) {final _that = this;
switch (_that) {
case FlashcardQuestion():
return flashcard(_that.front,_that.back);case MultipleChoiceQuestion():
return mcq(_that.question,_that.choices,_that.answerIndex,_that.explanation);case OpenEndedQuestion():
return openEnded(_that.question,_that.modelAnswer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String front,  String back)?  flashcard,TResult? Function( String question,  List<String> choices,  int answerIndex,  String explanation)?  mcq,TResult? Function( String question,  String modelAnswer)?  openEnded,}) {final _that = this;
switch (_that) {
case FlashcardQuestion() when flashcard != null:
return flashcard(_that.front,_that.back);case MultipleChoiceQuestion() when mcq != null:
return mcq(_that.question,_that.choices,_that.answerIndex,_that.explanation);case OpenEndedQuestion() when openEnded != null:
return openEnded(_that.question,_that.modelAnswer);case _:
  return null;

}
}

}

/// @nodoc


class FlashcardQuestion implements StudyQuestion {
  const FlashcardQuestion({required this.front, required this.back});


 final  String front;
 final  String back;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardQuestionCopyWith<FlashcardQuestion> get copyWith => _$FlashcardQuestionCopyWithImpl<FlashcardQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardQuestion&&(identical(other.front, front) || other.front == front)&&(identical(other.back, back) || other.back == back));
}


@override
int get hashCode {
    return Object.hash(runtimeType,front,back);
}

@override
String toString() {
    return 'StudyQuestion.flashcard(front: $front, back: $back)';
}


}

/// @nodoc
abstract mixin class $FlashcardQuestionCopyWith<$Res> implements $StudyQuestionCopyWith<$Res> {
  factory $FlashcardQuestionCopyWith(FlashcardQuestion value, $Res Function(FlashcardQuestion) _then) = _$FlashcardQuestionCopyWithImpl;
@useResult
$Res call({
 String front, String back
});




}
/// @nodoc
class _$FlashcardQuestionCopyWithImpl<$Res>
    implements $FlashcardQuestionCopyWith<$Res> {
  _$FlashcardQuestionCopyWithImpl(this._self, this._then);

  final FlashcardQuestion _self;
  final $Res Function(FlashcardQuestion) _then;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? front = null,Object? back = null,}) {
  return _then(FlashcardQuestion(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MultipleChoiceQuestion implements StudyQuestion {
  const MultipleChoiceQuestion({required this.question, required  List<String> choices, required this.answerIndex, required this.explanation}): _choices = choices;


 final  String question;
 final  List<String> _choices;
 List<String> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

 final  int answerIndex;
 final  String explanation;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleChoiceQuestionCopyWith<MultipleChoiceQuestion> get copyWith => _$MultipleChoiceQuestionCopyWithImpl<MultipleChoiceQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleChoiceQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.choices, _choices)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_choices),answerIndex,explanation);
}

@override
String toString() {
    return 'StudyQuestion.mcq(question: $question, choices: $choices, answerIndex: $answerIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class $MultipleChoiceQuestionCopyWith<$Res> implements $StudyQuestionCopyWith<$Res> {
  factory $MultipleChoiceQuestionCopyWith(MultipleChoiceQuestion value, $Res Function(MultipleChoiceQuestion) _then) = _$MultipleChoiceQuestionCopyWithImpl;
@useResult
$Res call({
 String question, List<String> choices, int answerIndex, String explanation
});




}
/// @nodoc
class _$MultipleChoiceQuestionCopyWithImpl<$Res>
    implements $MultipleChoiceQuestionCopyWith<$Res> {
  _$MultipleChoiceQuestionCopyWithImpl(this._self, this._then);

  final MultipleChoiceQuestion _self;
  final $Res Function(MultipleChoiceQuestion) _then;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? question = null,Object? choices = null,Object? answerIndex = null,Object? explanation = null,}) {
  return _then(MultipleChoiceQuestion(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OpenEndedQuestion implements StudyQuestion {
  const OpenEndedQuestion({required this.question, required this.modelAnswer});


 final  String question;
 final  String modelAnswer;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenEndedQuestionCopyWith<OpenEndedQuestion> get copyWith => _$OpenEndedQuestionCopyWithImpl<OpenEndedQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenEndedQuestion&&(identical(other.question, question) || other.question == question)&&(identical(other.modelAnswer, modelAnswer) || other.modelAnswer == modelAnswer));
}


@override
int get hashCode {
    return Object.hash(runtimeType,question,modelAnswer);
}

@override
String toString() {
    return 'StudyQuestion.openEnded(question: $question, modelAnswer: $modelAnswer)';
}


}

/// @nodoc
abstract mixin class $OpenEndedQuestionCopyWith<$Res> implements $StudyQuestionCopyWith<$Res> {
  factory $OpenEndedQuestionCopyWith(OpenEndedQuestion value, $Res Function(OpenEndedQuestion) _then) = _$OpenEndedQuestionCopyWithImpl;
@useResult
$Res call({
 String question, String modelAnswer
});




}
/// @nodoc
class _$OpenEndedQuestionCopyWithImpl<$Res>
    implements $OpenEndedQuestionCopyWith<$Res> {
  _$OpenEndedQuestionCopyWithImpl(this._self, this._then);

  final OpenEndedQuestion _self;
  final $Res Function(OpenEndedQuestion) _then;

/// Create a copy of StudyQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? question = null,Object? modelAnswer = null,}) {
  return _then(OpenEndedQuestion(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,modelAnswer: null == modelAnswer ? _self.modelAnswer : modelAnswer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$QuestionSet {

 int get id; QuestionFormat get format; DateTime get generatedAt; List<StudyQuestion> get questions;
/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSetCopyWith<QuestionSet> get copyWith => _$QuestionSetCopyWithImpl<QuestionSet>(this as QuestionSet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuestionSet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSet&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&const DeepCollectionEquality().equals(other.questions, _this.questions));
}


@override
int get hashCode {
  final _this = this as QuestionSet;
  return Object.hash(runtimeType,_this.id,_this.format,_this.generatedAt,const DeepCollectionEquality().hash(_this.questions));
}

@override
String toString() {
  final _this = this as QuestionSet;
  return 'QuestionSet(id: ${_this.id}, format: ${_this.format}, generatedAt: ${_this.generatedAt}, questions: ${_this.questions})';
}


}

/// @nodoc
abstract mixin class $QuestionSetCopyWith<$Res>  {
  factory $QuestionSetCopyWith(QuestionSet value, $Res Function(QuestionSet) _then) = _$QuestionSetCopyWithImpl;
@useResult
$Res call({
 int id, QuestionFormat format, DateTime generatedAt, List<StudyQuestion> questions
});




}
/// @nodoc
class _$QuestionSetCopyWithImpl<$Res>
    implements $QuestionSetCopyWith<$Res> {
  _$QuestionSetCopyWithImpl(this._self, this._then);

  final QuestionSet _self;
  final $Res Function(QuestionSet) _then;

/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? format = null,Object? generatedAt = null,Object? questions = null,}) {
  return _then(QuestionSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as QuestionFormat,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<StudyQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionSet].
extension QuestionSetPatterns on QuestionSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSet value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSet value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  QuestionFormat format,  DateTime generatedAt,  List<StudyQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  QuestionFormat format,  DateTime generatedAt,  List<StudyQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _QuestionSet():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  QuestionFormat format,  DateTime generatedAt,  List<StudyQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
return $default(_that.id,_that.format,_that.generatedAt,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionSet implements QuestionSet {
  const _QuestionSet({required this.id, required this.format, required this.generatedAt, required  List<StudyQuestion> questions}): _questions = questions;


@override final  int id;
@override final  QuestionFormat format;
@override final  DateTime generatedAt;
 final  List<StudyQuestion> _questions;
@override List<StudyQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSetCopyWith<_QuestionSet> get copyWith => __$QuestionSetCopyWithImpl<_QuestionSet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSet&&(identical(other.id, id) || other.id == id)&&(identical(other.format, format) || other.format == format)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other.questions, _questions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,format,generatedAt,const DeepCollectionEquality().hash(_questions));
}

@override
String toString() {
    return 'QuestionSet(id: $id, format: $format, generatedAt: $generatedAt, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuestionSetCopyWith<$Res> implements $QuestionSetCopyWith<$Res> {
  factory _$QuestionSetCopyWith(_QuestionSet value, $Res Function(_QuestionSet) _then) = __$QuestionSetCopyWithImpl;
@override @useResult
$Res call({
 int id, QuestionFormat format, DateTime generatedAt, List<StudyQuestion> questions
});




}
/// @nodoc
class __$QuestionSetCopyWithImpl<$Res>
    implements _$QuestionSetCopyWith<$Res> {
  __$QuestionSetCopyWithImpl(this._self, this._then);

  final _QuestionSet _self;
  final $Res Function(_QuestionSet) _then;

/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? format = null,Object? generatedAt = null,Object? questions = null,}) {
  return _then(_QuestionSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as QuestionFormat,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<StudyQuestion>,
  ));
}


}

/// @nodoc
mixin _$GenerationJob {

 int get id; int? get noteId; List<String> get outputs; String get status; String? get failureCode; String? get failureMessage; DateTime get createdAt; DateTime? get finishedAt;
/// Create a copy of GenerationJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationJobCopyWith<GenerationJob> get copyWith => _$GenerationJobCopyWithImpl<GenerationJob>(this as GenerationJob, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GenerationJob;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationJob&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&const DeepCollectionEquality().equals(other.outputs, _this.outputs)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.failureCode, _this.failureCode) || other.failureCode == _this.failureCode)&&(identical(other.failureMessage, _this.failureMessage) || other.failureMessage == _this.failureMessage)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.finishedAt, _this.finishedAt) || other.finishedAt == _this.finishedAt));
}


@override
int get hashCode {
  final _this = this as GenerationJob;
  return Object.hash(runtimeType,_this.id,_this.noteId,const DeepCollectionEquality().hash(_this.outputs),_this.status,_this.failureCode,_this.failureMessage,_this.createdAt,_this.finishedAt);
}

@override
String toString() {
  final _this = this as GenerationJob;
  return 'GenerationJob(id: ${_this.id}, noteId: ${_this.noteId}, outputs: ${_this.outputs}, status: ${_this.status}, failureCode: ${_this.failureCode}, failureMessage: ${_this.failureMessage}, createdAt: ${_this.createdAt}, finishedAt: ${_this.finishedAt})';
}


}

/// @nodoc
abstract mixin class $GenerationJobCopyWith<$Res>  {
  factory $GenerationJobCopyWith(GenerationJob value, $Res Function(GenerationJob) _then) = _$GenerationJobCopyWithImpl;
@useResult
$Res call({
 int id, int? noteId, List<String> outputs, String status, String? failureCode, String? failureMessage, DateTime createdAt, DateTime? finishedAt
});




}
/// @nodoc
class _$GenerationJobCopyWithImpl<$Res>
    implements $GenerationJobCopyWith<$Res> {
  _$GenerationJobCopyWithImpl(this._self, this._then);

  final GenerationJob _self;
  final $Res Function(GenerationJob) _then;

/// Create a copy of GenerationJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? noteId = freezed,Object? outputs = null,Object? status = null,Object? failureCode = freezed,Object? failureMessage = freezed,Object? createdAt = null,Object? finishedAt = freezed,}) {
  return _then(GenerationJob(
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


/// Adds pattern-matching-related methods to [GenerationJob].
extension GenerationJobPatterns on GenerationJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationJob value)  $default,){
final _that = this;
switch (_that) {
case _GenerationJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationJob value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? noteId,  List<String> outputs,  String status,  String? failureCode,  String? failureMessage,  DateTime createdAt,  DateTime? finishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationJob() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? noteId,  List<String> outputs,  String status,  String? failureCode,  String? failureMessage,  DateTime createdAt,  DateTime? finishedAt)  $default,) {final _that = this;
switch (_that) {
case _GenerationJob():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? noteId,  List<String> outputs,  String status,  String? failureCode,  String? failureMessage,  DateTime createdAt,  DateTime? finishedAt)?  $default,) {final _that = this;
switch (_that) {
case _GenerationJob() when $default != null:
return $default(_that.id,_that.noteId,_that.outputs,_that.status,_that.failureCode,_that.failureMessage,_that.createdAt,_that.finishedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GenerationJob implements GenerationJob {
  const _GenerationJob({required this.id, required this.noteId, required  List<String> outputs, required this.status, required this.failureCode, required this.failureMessage, required this.createdAt, required this.finishedAt}): _outputs = outputs;


@override final  int id;
@override final  int? noteId;
 final  List<String> _outputs;
@override List<String> get outputs {
  if (_outputs is EqualUnmodifiableListView) return _outputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outputs);
}

@override final  String status;
@override final  String? failureCode;
@override final  String? failureMessage;
@override final  DateTime createdAt;
@override final  DateTime? finishedAt;

/// Create a copy of GenerationJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationJobCopyWith<_GenerationJob> get copyWith => __$GenerationJobCopyWithImpl<_GenerationJob>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationJob&&(identical(other.id, id) || other.id == id)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&const DeepCollectionEquality().equals(other.outputs, _outputs)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,noteId,const DeepCollectionEquality().hash(_outputs),status,failureCode,failureMessage,createdAt,finishedAt);
}

@override
String toString() {
    return 'GenerationJob(id: $id, noteId: $noteId, outputs: $outputs, status: $status, failureCode: $failureCode, failureMessage: $failureMessage, createdAt: $createdAt, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class _$GenerationJobCopyWith<$Res> implements $GenerationJobCopyWith<$Res> {
  factory _$GenerationJobCopyWith(_GenerationJob value, $Res Function(_GenerationJob) _then) = __$GenerationJobCopyWithImpl;
@override @useResult
$Res call({
 int id, int? noteId, List<String> outputs, String status, String? failureCode, String? failureMessage, DateTime createdAt, DateTime? finishedAt
});




}
/// @nodoc
class __$GenerationJobCopyWithImpl<$Res>
    implements _$GenerationJobCopyWith<$Res> {
  __$GenerationJobCopyWithImpl(this._self, this._then);

  final _GenerationJob _self;
  final $Res Function(_GenerationJob) _then;

/// Create a copy of GenerationJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? noteId = freezed,Object? outputs = null,Object? status = null,Object? failureCode = freezed,Object? failureMessage = freezed,Object? createdAt = null,Object? finishedAt = freezed,}) {
  return _then(_GenerationJob(
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

/// @nodoc
mixin _$StudyPodcast {

 int? get id; int get noteId; String get title; DateTime get generatedAt; Duration get duration; String get audioUrl; String get script;
/// Create a copy of StudyPodcast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyPodcastCopyWith<StudyPodcast> get copyWith => _$StudyPodcastCopyWithImpl<StudyPodcast>(this as StudyPodcast, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyPodcast;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyPodcast&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.script, _this.script) || other.script == _this.script));
}


@override
int get hashCode {
  final _this = this as StudyPodcast;
  return Object.hash(runtimeType,_this.id,_this.noteId,_this.title,_this.generatedAt,_this.duration,_this.audioUrl,_this.script);
}

@override
String toString() {
  final _this = this as StudyPodcast;
  return 'StudyPodcast(id: ${_this.id}, noteId: ${_this.noteId}, title: ${_this.title}, generatedAt: ${_this.generatedAt}, duration: ${_this.duration}, audioUrl: ${_this.audioUrl}, script: ${_this.script})';
}


}

/// @nodoc
abstract mixin class $StudyPodcastCopyWith<$Res>  {
  factory $StudyPodcastCopyWith(StudyPodcast value, $Res Function(StudyPodcast) _then) = _$StudyPodcastCopyWithImpl;
@useResult
$Res call({
 int? id, int noteId, String title, DateTime generatedAt, Duration duration, String audioUrl, String script
});




}
/// @nodoc
class _$StudyPodcastCopyWithImpl<$Res>
    implements $StudyPodcastCopyWith<$Res> {
  _$StudyPodcastCopyWithImpl(this._self, this._then);

  final StudyPodcast _self;
  final $Res Function(StudyPodcast) _then;

/// Create a copy of StudyPodcast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? noteId = null,Object? title = null,Object? generatedAt = null,Object? duration = null,Object? audioUrl = null,Object? script = null,}) {
  return _then(StudyPodcast(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,script: null == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyPodcast].
extension StudyPodcastPatterns on StudyPodcast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyPodcast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyPodcast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyPodcast value)  $default,){
final _that = this;
switch (_that) {
case _StudyPodcast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyPodcast value)?  $default,){
final _that = this;
switch (_that) {
case _StudyPodcast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int noteId,  String title,  DateTime generatedAt,  Duration duration,  String audioUrl,  String script)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyPodcast() when $default != null:
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.duration,_that.audioUrl,_that.script);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int noteId,  String title,  DateTime generatedAt,  Duration duration,  String audioUrl,  String script)  $default,) {final _that = this;
switch (_that) {
case _StudyPodcast():
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.duration,_that.audioUrl,_that.script);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int noteId,  String title,  DateTime generatedAt,  Duration duration,  String audioUrl,  String script)?  $default,) {final _that = this;
switch (_that) {
case _StudyPodcast() when $default != null:
return $default(_that.id,_that.noteId,_that.title,_that.generatedAt,_that.duration,_that.audioUrl,_that.script);case _:
  return null;

}
}

}

/// @nodoc


class _StudyPodcast implements StudyPodcast {
  const _StudyPodcast({required this.id, required this.noteId, this.title = '', required this.generatedAt, required this.duration, required this.audioUrl, required this.script});


@override final  int? id;
@override final  int noteId;
@override@JsonKey() final  String title;
@override final  DateTime generatedAt;
@override final  Duration duration;
@override final  String audioUrl;
@override final  String script;

/// Create a copy of StudyPodcast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyPodcastCopyWith<_StudyPodcast> get copyWith => __$StudyPodcastCopyWithImpl<_StudyPodcast>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyPodcast&&(identical(other.id, id) || other.id == id)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&(identical(other.title, title) || other.title == title)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.script, script) || other.script == script));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,noteId,title,generatedAt,duration,audioUrl,script);
}

@override
String toString() {
    return 'StudyPodcast(id: $id, noteId: $noteId, title: $title, generatedAt: $generatedAt, duration: $duration, audioUrl: $audioUrl, script: $script)';
}


}

/// @nodoc
abstract mixin class _$StudyPodcastCopyWith<$Res> implements $StudyPodcastCopyWith<$Res> {
  factory _$StudyPodcastCopyWith(_StudyPodcast value, $Res Function(_StudyPodcast) _then) = __$StudyPodcastCopyWithImpl;
@override @useResult
$Res call({
 int? id, int noteId, String title, DateTime generatedAt, Duration duration, String audioUrl, String script
});




}
/// @nodoc
class __$StudyPodcastCopyWithImpl<$Res>
    implements _$StudyPodcastCopyWith<$Res> {
  __$StudyPodcastCopyWithImpl(this._self, this._then);

  final _StudyPodcast _self;
  final $Res Function(_StudyPodcast) _then;

/// Create a copy of StudyPodcast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? noteId = null,Object? title = null,Object? generatedAt = null,Object? duration = null,Object? audioUrl = null,Object? script = null,}) {
  return _then(_StudyPodcast(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,script: null == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PodcastDownloadedEpisode {

 String get environment; String get accountId; int get noteId; String get episodeKey; String get title; String get courseLabel; String get localPath; int get sizeBytes; Duration get duration; DateTime? get downloadedAt; PodcastDownloadStatus get status;
/// Create a copy of PodcastDownloadedEpisode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastDownloadedEpisodeCopyWith<PodcastDownloadedEpisode> get copyWith => _$PodcastDownloadedEpisodeCopyWithImpl<PodcastDownloadedEpisode>(this as PodcastDownloadedEpisode, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PodcastDownloadedEpisode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastDownloadedEpisode&&(identical(other.environment, _this.environment) || other.environment == _this.environment)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&(identical(other.episodeKey, _this.episodeKey) || other.episodeKey == _this.episodeKey)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.courseLabel, _this.courseLabel) || other.courseLabel == _this.courseLabel)&&(identical(other.localPath, _this.localPath) || other.localPath == _this.localPath)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.downloadedAt, _this.downloadedAt) || other.downloadedAt == _this.downloadedAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as PodcastDownloadedEpisode;
  return Object.hash(runtimeType,_this.environment,_this.accountId,_this.noteId,_this.episodeKey,_this.title,_this.courseLabel,_this.localPath,_this.sizeBytes,_this.duration,_this.downloadedAt,_this.status);
}

@override
String toString() {
  final _this = this as PodcastDownloadedEpisode;
  return 'PodcastDownloadedEpisode(environment: ${_this.environment}, accountId: ${_this.accountId}, noteId: ${_this.noteId}, episodeKey: ${_this.episodeKey}, title: ${_this.title}, courseLabel: ${_this.courseLabel}, localPath: ${_this.localPath}, sizeBytes: ${_this.sizeBytes}, duration: ${_this.duration}, downloadedAt: ${_this.downloadedAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $PodcastDownloadedEpisodeCopyWith<$Res>  {
  factory $PodcastDownloadedEpisodeCopyWith(PodcastDownloadedEpisode value, $Res Function(PodcastDownloadedEpisode) _then) = _$PodcastDownloadedEpisodeCopyWithImpl;
@useResult
$Res call({
 String environment, String accountId, int noteId, String episodeKey, String title, String courseLabel, String localPath, int sizeBytes, Duration duration, DateTime? downloadedAt, PodcastDownloadStatus status
});




}
/// @nodoc
class _$PodcastDownloadedEpisodeCopyWithImpl<$Res>
    implements $PodcastDownloadedEpisodeCopyWith<$Res> {
  _$PodcastDownloadedEpisodeCopyWithImpl(this._self, this._then);

  final PodcastDownloadedEpisode _self;
  final $Res Function(PodcastDownloadedEpisode) _then;

/// Create a copy of PodcastDownloadedEpisode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? environment = null,Object? accountId = null,Object? noteId = null,Object? episodeKey = null,Object? title = null,Object? courseLabel = null,Object? localPath = null,Object? sizeBytes = null,Object? duration = null,Object? downloadedAt = freezed,Object? status = null,}) {
  return _then(PodcastDownloadedEpisode(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,episodeKey: null == episodeKey ? _self.episodeKey : episodeKey // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,downloadedAt: freezed == downloadedAt ? _self.downloadedAt : downloadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PodcastDownloadStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [PodcastDownloadedEpisode].
extension PodcastDownloadedEpisodePatterns on PodcastDownloadedEpisode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PodcastDownloadedEpisode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PodcastDownloadedEpisode value)  $default,){
final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PodcastDownloadedEpisode value)?  $default,){
final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String environment,  String accountId,  int noteId,  String episodeKey,  String title,  String courseLabel,  String localPath,  int sizeBytes,  Duration duration,  DateTime? downloadedAt,  PodcastDownloadStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode() when $default != null:
return $default(_that.environment,_that.accountId,_that.noteId,_that.episodeKey,_that.title,_that.courseLabel,_that.localPath,_that.sizeBytes,_that.duration,_that.downloadedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String environment,  String accountId,  int noteId,  String episodeKey,  String title,  String courseLabel,  String localPath,  int sizeBytes,  Duration duration,  DateTime? downloadedAt,  PodcastDownloadStatus status)  $default,) {final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode():
return $default(_that.environment,_that.accountId,_that.noteId,_that.episodeKey,_that.title,_that.courseLabel,_that.localPath,_that.sizeBytes,_that.duration,_that.downloadedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String environment,  String accountId,  int noteId,  String episodeKey,  String title,  String courseLabel,  String localPath,  int sizeBytes,  Duration duration,  DateTime? downloadedAt,  PodcastDownloadStatus status)?  $default,) {final _that = this;
switch (_that) {
case _PodcastDownloadedEpisode() when $default != null:
return $default(_that.environment,_that.accountId,_that.noteId,_that.episodeKey,_that.title,_that.courseLabel,_that.localPath,_that.sizeBytes,_that.duration,_that.downloadedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _PodcastDownloadedEpisode implements PodcastDownloadedEpisode {
  const _PodcastDownloadedEpisode({required this.environment, required this.accountId, required this.noteId, required this.episodeKey, required this.title, required this.courseLabel, required this.localPath, required this.sizeBytes, required this.duration, required this.downloadedAt, required this.status});


@override final  String environment;
@override final  String accountId;
@override final  int noteId;
@override final  String episodeKey;
@override final  String title;
@override final  String courseLabel;
@override final  String localPath;
@override final  int sizeBytes;
@override final  Duration duration;
@override final  DateTime? downloadedAt;
@override final  PodcastDownloadStatus status;

/// Create a copy of PodcastDownloadedEpisode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastDownloadedEpisodeCopyWith<_PodcastDownloadedEpisode> get copyWith => __$PodcastDownloadedEpisodeCopyWithImpl<_PodcastDownloadedEpisode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PodcastDownloadedEpisode&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&(identical(other.episodeKey, episodeKey) || other.episodeKey == episodeKey)&&(identical(other.title, title) || other.title == title)&&(identical(other.courseLabel, courseLabel) || other.courseLabel == courseLabel)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.downloadedAt, downloadedAt) || other.downloadedAt == downloadedAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,environment,accountId,noteId,episodeKey,title,courseLabel,localPath,sizeBytes,duration,downloadedAt,status);
}

@override
String toString() {
    return 'PodcastDownloadedEpisode(environment: $environment, accountId: $accountId, noteId: $noteId, episodeKey: $episodeKey, title: $title, courseLabel: $courseLabel, localPath: $localPath, sizeBytes: $sizeBytes, duration: $duration, downloadedAt: $downloadedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PodcastDownloadedEpisodeCopyWith<$Res> implements $PodcastDownloadedEpisodeCopyWith<$Res> {
  factory _$PodcastDownloadedEpisodeCopyWith(_PodcastDownloadedEpisode value, $Res Function(_PodcastDownloadedEpisode) _then) = __$PodcastDownloadedEpisodeCopyWithImpl;
@override @useResult
$Res call({
 String environment, String accountId, int noteId, String episodeKey, String title, String courseLabel, String localPath, int sizeBytes, Duration duration, DateTime? downloadedAt, PodcastDownloadStatus status
});




}
/// @nodoc
class __$PodcastDownloadedEpisodeCopyWithImpl<$Res>
    implements _$PodcastDownloadedEpisodeCopyWith<$Res> {
  __$PodcastDownloadedEpisodeCopyWithImpl(this._self, this._then);

  final _PodcastDownloadedEpisode _self;
  final $Res Function(_PodcastDownloadedEpisode) _then;

/// Create a copy of PodcastDownloadedEpisode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? environment = null,Object? accountId = null,Object? noteId = null,Object? episodeKey = null,Object? title = null,Object? courseLabel = null,Object? localPath = null,Object? sizeBytes = null,Object? duration = null,Object? downloadedAt = freezed,Object? status = null,}) {
  return _then(_PodcastDownloadedEpisode(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,noteId: null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as int,episodeKey: null == episodeKey ? _self.episodeKey : episodeKey // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseLabel: null == courseLabel ? _self.courseLabel : courseLabel // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,downloadedAt: freezed == downloadedAt ? _self.downloadedAt : downloadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PodcastDownloadStatus,
  ));
}


}

// dart format on
