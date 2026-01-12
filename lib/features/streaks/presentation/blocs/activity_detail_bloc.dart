import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_detail_event.dart';
part 'activity_detail_state.dart';

class ActivityDetailBloc extends Bloc<ActivityDetailEvent, ActivityDetailState> {
  final GetActivityById getActivityById;

  ActivityDetailBloc({required this.getActivityById}) : super(ActivityDetailInitial()) {
    on<LoadActivityDetail>(_onLoadActivityDetail);
  }

  Future<void> _onLoadActivityDetail(
    LoadActivityDetail event,
    Emitter<ActivityDetailState> emit,
  ) async {
    emit(ActivityDetailLoading());

    final result = await getActivityById(event.id);

    result.fold(
      (failure) => emit(ActivityDetailError(failure.message)),
      (activity) => emit(ActivityDetailLoaded(activity)),
    );
  }
}
