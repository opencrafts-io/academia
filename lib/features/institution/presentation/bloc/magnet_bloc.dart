import 'dart:convert';

import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnet/magnet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/features/course/course.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

part 'magnet_state.dart';
part 'magnet_event.dart';

class MagnetBloc extends Bloc<MagnetEvent, MagnetState> {
  Magnet? _magnet;
  final SyncInstitutionProfileUsecase syncInstitutionProfileUsecase;
  final SaveFeeTransaction saveFeeTransaction;
  final SaveCourseUsecase saveCourseUsecase;
  final CreateOrUpdateTimetableEntries createOrUpdateTimetableEntries;

  MagnetBloc({
    required this.syncInstitutionProfileUsecase,
    required this.saveFeeTransaction,
    required this.saveCourseUsecase,
    required this.createOrUpdateTimetableEntries,
  }) : super(MagnetInitial()) {
    on<InitializeMagnet>(_onInitialize);
    on<ExecuteScrappingCommand>(_onExecute);
  }

  Future<void> _onInitialize(
    InitializeMagnet event,
    Emitter<MagnetState> emit,
  ) async {
    emit(MagnetInitializing());
    try {
      _magnet = await Magnet.init(config: event.config);
      emit(MagnetReady(_magnet!));
    } catch (e) {
      emit(MagnetError("Failed to wake up the magnet: $e"));
    }
  }

  Future<void> _onExecute(
    ExecuteScrappingCommand event,
    Emitter<MagnetState> emit,
  ) async {
    if (_magnet == null || !_magnet!.initialized) {
      emit(const MagnetError("Magnet is not initialized. Check the pipes!"));
      return;
    }

    // Keep track of the previous state so we can return to "Ready" after success
    // final prevState = state;
    final cmd = _hydrateWithKeys(event.command, event.institutionKey);
    emit(MagnetProcessing(command: cmd));

    try {
      final callback = InstructionCallbackManager();
      final magnetFuture = _magnet!.execute(
        cmd,
        context: event.context,
        callbackManager: callback,
      );

      await emit.forEach<InstructionProgressEvent>(
        callback.progressStream,
        onData: (data) {
          return MagnetProcessing(command: cmd, progress: data);
        },
        onError: (error, stackTrace) => MagnetError("Stream error: $error"),
      );

      final result = await magnetFuture;
      callback.dispose();

      if (result.success) {
        // Logger().i(result.data);
        final String rawJson = jsonEncode(result.data);
        final Map<String, dynamic> computableData = jsonDecode(rawJson);

        compute(_parseRawFeesTransactions, computableData).then((transactions) {
          for (final transaction in transactions) {
            saveFeeTransaction(transaction);
          }
        });

        _processCoursesInBackground(
          computableData,
          event.userID,
          timetableId: null,
        ).then((coursesWithSchedules) async {
          for (final courseWithSchedule in coursesWithSchedules) {
            final result = await saveCourseUsecase(courseWithSchedule.course);
            if (result.isLeft()) {
              Logger().e(
                "Failed to save course ${courseWithSchedule.course.courseName} skipping",
                error: (result as Left).value,
              );
              continue;
            }
            final entryResult = await createOrUpdateTimetableEntries(
              CreateOrUpdateTimetableEntriesParams(
                entries: courseWithSchedule.schedules,
              ),
            );

            if (entryResult.isLeft()) {
              Logger().e(
                "Failed to save timetable entries for course ${courseWithSchedule.course.courseName} skipping",
                error: (entryResult as Left).value,
              );
              continue;
            }
          }
        });

        await syncInstitutionProfileUsecase(
          SyncProfileParams(
            rawData: result.data,
            userId: event.userID,
            institutionId: event.institutionID,
          ),
        );
        emit(MagnetSuccess(result));
      } else {
        emit(MagnetError(result.error ?? "Unknown scrapping error"));
      }
    } catch (e) {
      emit(MagnetError("Sewer apples... Execution failed: $e"));
    }
  }

  ScrappingCommand _hydrateWithKeys(
    ScrappingCommand command,
    InstitutionKey key,
  ) {
    final updatedInstructions = command.instructions.map((instruction) {
      if (instruction.type == 'fill-form') {
        final lookupKey = instruction.valueKey ?? instruction.selectorToUse;

        if (key.keySets.containsKey(lookupKey)) {
          final newValue = key.keySets[lookupKey]?.toString();

          return instruction.copyWith(value: newValue);
        }
      }

      return instruction;
    }).toList();

    return command.copyWith(instructions: updatedInstructions);
  }
}

List<InstitutionFeeTransaction> _parseRawFeesTransactions(
  Map<String, dynamic> data,
) {
  final List<dynamic> rawList = data['fees_fees_statements'] ?? [];
  return rawList.map((json) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(json);
    return InstitutionFeeTransaction(
      title: map['title'],
      institution: int.tryParse(map['institution'].toString()) ?? 0,
      referenceNumber: map['reference_number'],
      runningBalance: double.tryParse(
        map['balance'].toString().replaceAll(',', ''),
      ),
      debit: double.tryParse(map['debit'].toString().replaceAll(',', '')),
      credit: double.tryParse(map['credit'].toString().replaceAll(',', '')),
      postingDate:
          DateTime.tryParse(map['posting_date'] ?? map['date'] ?? '') ??
          DateTime.now(),
      description: map['description'],
      currency: map['currency'],
    );
  }).toList();
}

Future<List<CourseWithSchedules>> _processCoursesInBackground(
  Map<String, dynamic> data,
  String userId, {
  String? timetableId,
}) {
  return compute(
    (Map<String, dynamic> params) => _parseRawCoursesWithSchedules(
      params['data'],
      userId: params['userId'],
      timetableId: params['timetableId'],
    ),
    {'data': data, 'userId': userId, 'timetableId': timetableId},
  );
}

/// Parses raw course data including nested course_schedules
List<CourseWithSchedules> _parseRawCoursesWithSchedules(
  Map<String, dynamic> data, {
  required String userId,
  required String? timetableId,
}) {
  final List<dynamic> rawList = data['courses'] ?? [];
  const uuid = Uuid();

  return rawList.map((json) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(json);

    // Generate a UUID for the course if not present
    final courseId = map['id']?.toString() ?? uuid.v4();

    // Parse the main course entity
    final course = CourseEntity(
      id: courseId,
      courseCode: map["course_code"] ?? '',
      courseName: map['course_name'] ?? map["course_code"] ?? '',
      instructor: map['instructor'] ?? '',
      isSynced: map['is_synced'] ?? false,
      color: Color(
        int.tryParse(
              map['color']
                      ?.toString()
                      .replaceAll('0x', '')
                      .replaceAll('0X', '') ??
                  '',
              radix: 16,
            ) ??
            0xFFCBA6F7,
      ),
      isDeleted: map['is_deleted'] ?? false,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      institutionId: int.tryParse(map["institution_id"]?.toString() ?? '0'),
      serverId: map['server_id'] != null
          ? int.tryParse(map['server_id'].toString())
          : null,
      semesterId: map['semester_id'] != null
          ? int.tryParse(map['semester_id'].toString())
          : null,
    );

    // Parse nested course_schedules
    final List<dynamic> rawSchedules = map['course_schedules'] ?? [];
    final schedules = rawSchedules.map((scheduleJson) {
      final Map<String, dynamic> scheduleMap = Map<String, dynamic>.from(
        scheduleJson,
      );

      return TimetableEntryEntity(
        id: scheduleMap['id']?.toString() ?? uuid.v4(),
        serverId: scheduleMap['server_id'] != null
            ? int.tryParse(scheduleMap['server_id'].toString())
            : null,
        userId: scheduleMap['user_id']?.toString() ?? userId,
        institutionId:
            int.tryParse(
              scheduleMap['institution_id']?.toString() ??
                  map['institution_id']?.toString() ??
                  '0',
            ) ??
            0,
        courseId: courseId, // Use the course ID we generated/got above
        timetableId:
            scheduleMap['timetable_id']?.toString() ?? timetableId ?? uuid.v4(),
        rrule: scheduleMap['rrule']?.toString(),
        startDate: scheduleMap['start_date'] != null
            ? DateTime.parse(scheduleMap['start_date'])
            : DateTime.now(),
        durationMinutes:
            int.tryParse(scheduleMap['duration_minutes']?.toString() ?? '0') ??
            0,
        location: scheduleMap['location']?.toString(),
        room: scheduleMap['room']?.toString(),
        building: scheduleMap['building']?.toString(),
        isSynced: scheduleMap['is_synced'] ?? false,
        isDeleted: scheduleMap['is_deleted'] ?? false,
        lastUpdated: scheduleMap['last_updated'] != null
            ? DateTime.parse(scheduleMap['last_updated'])
            : DateTime.now(),
      );
    }).toList();

    return CourseWithSchedules(course: course, schedules: schedules);
  }).toList();
}
