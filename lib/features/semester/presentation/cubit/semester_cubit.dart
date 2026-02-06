import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'semester_state.dart';

class SemesterCubit extends Cubit<SemesterState> {
  final CreateSemesterUsecase createSemesterUsecase;
  final DeleteSemesterUsecase deleteSemesterUsecase;
  final GetSemestersForInstituionUsecase getSemestersForInstitutionUsecase;
  final UpdateSemesterUsecase updateSemesterUsecase;
  final WatchAllSemestersUsecase watchAllSemestersUsecase;

  SemesterCubit({
    required this.createSemesterUsecase,
    required this.deleteSemesterUsecase,
    required this.getSemestersForInstitutionUsecase,
    required this.updateSemesterUsecase,
    required this.watchAllSemestersUsecase,
  }) : super(SemesterInitialState());

  Future<void> createSemester(SemesterEntity semester) async {
    emit(SemesterLoadingState());
    final result = await createSemesterUsecase(semester);
    result.fold(
      (failure) => emit(SemesterErrorState(error: failure.message)),
      (_) {},
    );
  }

  Future<void> deleteSemester(int semesterId) async {
    emit(SemesterLoadingState());
    final result = await deleteSemesterUsecase(semesterId);
    result.fold(
      (failure) => emit(SemesterErrorState(error: failure.message)),
      (_) {}, // Refresh or fetch semesters
    );
  }

  Future<void> getSemesters(int institutionId) async {
    emit(SemesterLoadingState());
    final result = await getSemestersForInstitutionUsecase(institutionId);
    result.fold(
      (failure) => emit(SemesterErrorState(error: failure.message)),
      (semesters) => emit(SemesterLoadedState(semesters: semesters)),
    );
  }

  Future<void> updateSemester(SemesterEntity semester) async {
    emit(SemesterLoadingState());
    final result = await updateSemesterUsecase(semester);
    result.fold(
      (failure) => emit(SemesterErrorState(error: failure.message)),
      (_) {},
    );
  }

  Stream<void> watchAllSemesters() async* {
    emit(SemesterLoadingState());
    await for (final result in watchAllSemestersUsecase(NoParams())) {
      result.fold(
        (failure) => emit(SemesterErrorState(error: failure.message)),
        (semesters) => emit(SemesterLoadedState(semesters: semesters)),
      );
    }
  }
}
