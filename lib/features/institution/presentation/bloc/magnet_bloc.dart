import 'dart:convert';

import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnet/magnet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:academia/features/course/course.dart';
import 'package:logger/logger.dart';

export 'magnet_state.dart';

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
  }) : super(const MagnetState.initial()) {
    on<InitializeMagnet>(_onInitialize);
    on<ExecuteScrappingCommand>(_onExecute);
  }

  Future<void> _onInitialize(
    InitializeMagnet event,
    Emitter<MagnetState> emit,
  ) async {
    emit(const MagnetState.initializing());
    try {
      _magnet = await Magnet.init(config: event.config);
      emit(MagnetState.ready(_magnet!));
    } catch (e) {
      emit(MagnetState.error("Failed to wake up the magnet: $e"));
    }
  }

  Future<void> _onExecute(
    ExecuteScrappingCommand event,
    Emitter<MagnetState> emit,
  ) async {
    if (_magnet == null || !_magnet!.initialized) {
      emit(
        const MagnetState.error("Magnet is not initialized. Check the pipes!"),
      );
      return;
    }

    // Keep track of the previous state so we can return to "Ready" after success
    // final prevState = state;
    final cmd = _hydrateWithKeys(event.command, event.institutionKey);
    emit(MagnetState.processing(command: cmd));

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
          return MagnetState.processing(command: cmd, progress: data);
        },
        onError: (error, stackTrace) =>
            MagnetState.error("Stream error: $error"),
      );

      final result = await magnetFuture;
      callback.dispose();

      if (result.success) {
        // Logger().i(result.data);
        final String rawJson = jsonEncode(result.data);
        final Map<String, dynamic> computableData = jsonDecode(rawJson);

        final transactions = await compute(
          parseFeeTransactionsFromScrape,
          computableData,
        );
        for (final transaction in transactions) {
          final saveResult = await saveFeeTransaction(transaction);
          if (saveResult.isLeft()) {
            Logger().e(
              "Failed to save fee transaction ${transaction.referenceNumber}, skipping",
              error: (saveResult as Left).value,
            );
          }
        }

        final coursesWithSchedules = await parseCoursesInBackground(
          computableData,
          event.userID,
          timetableId: null,
        );
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

        await syncInstitutionProfileUsecase(
          SyncProfileParams(
            rawData: result.data,
            userId: event.userID,
            institutionId: event.institutionID,
          ),
        );
        emit(MagnetState.success(result));
      } else {
        emit(MagnetState.error(result.error ?? "Unknown scrapping error"));
      }
    } catch (e) {
      emit(MagnetState.error("Sewer apples... Execution failed: $e"));
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
