import 'dart:convert';

import 'package:academia/features/institution/institution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnet/magnet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/features/course/course.dart';
import 'package:logger/logger.dart';

part 'magnet_state.dart';
part 'magnet_event.dart';

class MagnetBloc extends Bloc<MagnetEvent, MagnetState> {
  Magnet? _magnet;
  final SyncInstitutionProfileUsecase syncInstitutionProfileUsecase;
  final SaveFeeTransaction saveFeeTransaction;
  final SaveCourseUsecase saveCourseUsecase;

  MagnetBloc({
    required this.syncInstitutionProfileUsecase,
    required this.saveFeeTransaction,
    required this.saveCourseUsecase,
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
      final magnetResult = _magnet!
          .execute(cmd, context: event.context, callbackManager: callback)
          .whenComplete(() => callback.dispose());

      await emit.forEach(
        callback.progressStream,
        onData: (data) => MagnetProcessing(command: cmd, progress: data),
        onError: (error, stackTrace) => MagnetError("Stream error: $error"),
      );

      final result = await magnetResult;

      if (result.success) {
        final String rawJson = jsonEncode(result.data);
        final Map<String, dynamic> computableData = jsonDecode(rawJson);

        Logger().i(computableData);

        compute(_parseRawFeesTransactions, computableData).then((transactions) {
          for (final transaction in transactions) {
            saveFeeTransaction(transaction);
          }
        });

        compute(_parseRawCourses, computableData).then((courses) {
          for (final course in courses) {
            saveCourseUsecase(course);
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
      postingDate: DateTime.tryParse(map['posting_date'] ?? map['date']),
      description: map['description'],
      currency: map['currency'],
    );
  }).toList();
}

List<CourseEntity> _parseRawCourses(Map<String, dynamic> data) {
  final List<dynamic> rawList = data['courses'] ?? [];
  return rawList.map((json) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(json);
    return CourseEntity(
      courseCode: map["course_code"],
      courseName: map['course_name'] ?? map['course_code'],
      instructor: map['instructor'] ?? '',
      isSynced: false,
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
      isDeleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      institutionId: map["institution_id"],
    );
  }).toList();
}
