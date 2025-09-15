part of 'create_community_bloc.dart';

abstract class CreateCommunityEvent extends Equatable {
  const CreateCommunityEvent();

  @override
  List<Object?> get props => [];
}

class SubmitNewCommunity extends CreateCommunityEvent {
  final String name;
  final String description;
  final bool isPublic;
  final String userId;
  final String userName;
  final String userEmail;
  final String? logoPath;
  final String? bannerPath;

  const SubmitNewCommunity({
    required this.name,
    required this.description,
    required this.isPublic,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.logoPath,
    this.bannerPath,
  });

  @override
  List<Object?> get props => [
    name,
    description,
    isPublic,
    userId,
    userName,
    userEmail,
    logoPath,
    bannerPath,
  ];
}
