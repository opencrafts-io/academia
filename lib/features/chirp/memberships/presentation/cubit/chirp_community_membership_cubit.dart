import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chirp_community_membership_state.dart';

class ChirpCommunityMembershipCubit
    extends Cubit<ChirpCommunityMembershipState> {
  ChirpCommunityMembershipCubit()
    : super(ChirpCommunityMembershipInitialState());
}
