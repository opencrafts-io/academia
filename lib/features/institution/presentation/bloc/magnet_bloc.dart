import 'package:academia/features/institution/institution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnet/magnet.dart';
import 'package:flutter/material.dart';

part 'magnet_state.dart';
part 'magnet_event.dart';

class MagnetBloc extends Bloc<MagnetEvent, MagnetState> {
  Magnet? _magnet;

  MagnetBloc() : super(MagnetInitial()) {
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
        emit(MagnetSuccess(result));
        // Optionally revert to Ready state after a delay or user acknowledgement
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
