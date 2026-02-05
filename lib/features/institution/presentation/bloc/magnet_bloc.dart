import 'dart:convert';

import 'package:academia/features/institution/institution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnet/magnet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

part 'magnet_state.dart';
part 'magnet_event.dart';

class MagnetBloc extends Bloc<MagnetEvent, MagnetState> {
  Magnet? _magnet;
  final SyncInstitutionProfileUsecase syncInstitutionProfileUsecase;
  final SaveFeeTransaction saveFeeTransaction;

  MagnetBloc({
    required this.syncInstitutionProfileUsecase,
    required this.saveFeeTransaction,
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

        final List<InstitutionFeeTransaction> transactions = await compute(
          _parseRawFeesTransactions,
          computableData,
        );

        for (var transaction in transactions) {
          saveFeeTransaction(transaction);
        }

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
      postingDate: DateTime.tryParse(map['posting_date']),
      description: map['description'],
      currency: map['currency'],
    );
  }).toList();
}
