import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportContent reportContent;
  final GetReports getReports;

  ReportBloc({required this.reportContent, required this.getReports})
    : super(ReportInitial()) {
    on<ReportContentEvent>(_onReportContent);
    on<GetReportsEvent>(_onGetReports);
  }

  Future<void> _onReportContent(
    ReportContentEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    final result = await reportContent(
      ReportContentParams(
        reportType: event.reportType,
        entityId: event.entityId,
        reason: event.reason,
      ),
    );

    result.fold(
      (failure) => emit(ReportError(message: failure.message)),
      (report) => emit(
        const ReportSubmitted(
          message: 'Report submitted successfully. Our team will review it.',
        ),
      ),
    );
  }

  Future<void> _onGetReports(
    GetReportsEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    final result = await getReports(
      GetReportsParams(type: event.type, status: event.status),
    );

    result.fold(
      (failure) => emit(ReportError(message: failure.message)),
      (reports) => emit(ReportsLoaded(reports: reports)),
    );
  }
}
