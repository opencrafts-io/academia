import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'create_community_state.dart';

part 'create_community_event.dart';

class CreateCommunityBloc
    extends Bloc<CreateCommunityEvent, CreateCommunityState> {
  final CreateCommunityUseCase createCommunityUseCase;

  CreateCommunityBloc({required this.createCommunityUseCase})
    : super(const CreateCommunityState.initial()) {
    on<SubmitNewCommunity>(_onSubmitNewCommunity);
  }

  Future<void> _onSubmitNewCommunity(
    SubmitNewCommunity event,
    Emitter<CreateCommunityState> emit,
  ) async {
    emit(const CreateCommunityState.loading());

    final Either<Failure, Community> result = await createCommunityUseCase.call(
      event.community,
    );

    result.fold(
      (failure) =>
          emit(CreateCommunityState.failure(message: failure.message)),
      (community) =>
          emit(CreateCommunityState.success(community: community)),
    );
  }
}
