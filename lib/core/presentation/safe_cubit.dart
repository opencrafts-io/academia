import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeCubit<S> extends Cubit<S> {
  SafeCubit(super.initialState);

  @override
  void emit(S state) {
    if (!isClosed) super.emit(state);
  }
}
