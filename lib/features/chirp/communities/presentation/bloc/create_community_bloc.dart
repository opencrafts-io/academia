import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:academia/features/chirp/communities/domain/usecases/create_community_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_community_event.dart';
part 'create_community_state.dart';

class CreateCommunityBloc
    extends Bloc<CreateCommunityEvent, CreateCommunityState> {
  final CreateCommunityUseCase createCommunityUseCase;

  CreateCommunityBloc({required this.createCommunityUseCase})
    : super(CreateCommunityInitial()) {
    on<SubmitNewCommunity>(_onSubmitNewCommunity);
  }

  Future<void> _onSubmitNewCommunity(
    SubmitNewCommunity event,
    Emitter<CreateCommunityState> emit,
  ) async {
    emit(CreateCommunityLoading());

    final Either<Failure, Community> result = await createCommunityUseCase.call(
      event.community,
    );

    result.fold(
      (failure) => emit(CreateCommunityFailure(message: failure.message)),
      (community) => emit(CreateCommunitySuccess(community: community)),
    );
  }
}
