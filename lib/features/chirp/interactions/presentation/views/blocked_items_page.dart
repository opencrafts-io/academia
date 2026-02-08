import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../widgets/blocked_community_card.dart';
import '../widgets/blocked_user_card.dart';

class BlockedItemsPage extends StatelessWidget {
  const BlockedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BlockBloc>()..add(const GetBlocksEvent()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Blocked'),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Users', icon: Icon(Icons.person_outline)),
                Tab(text: 'Communities', icon: Icon(Icons.people_outline)),
              ],
              onTap: (index) {
                context.read<BlockBloc>().add(
                  GetBlocksEvent(type: index == 0 ? 'user' : 'community'),
                );
              },
            ),
          ),
          body: const TabBarView(
            children: [BlockedUsersTab(), BlockedCommunitiesTab()],
          ),
        ),
      ),
    );
  }
}

class BlockedUsersTab extends StatelessWidget {
  const BlockedUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlockActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<BlockBloc>().add(const GetBlocksEvent(type: 'user'));
        } else if (state is BlockError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BlockLoading) {
          return const Center(child: SpinningScallopIndicator());
        }

        if (state is BlocksLoaded) {
          final userBlocks = state.blocks
              .where((block) => block.blockType == 'user')
              .toList();

          if (userBlocks.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lotties/organize.json",
                      height: 200,
                      repeat: false,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No blocked users',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Users you block will appear here',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<BlockBloc>().add(const GetBlocksEvent(type: 'user'));
            },
            child: ListView.builder(
              itemCount: userBlocks.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) => ChirpUserCubit(
                    getChirpUserByIdUsecase: sl(),
                    getChirpUserByUsernameUsecase: sl(),
                  )..getChirpUserByID(userBlocks[index].blockedId ?? ''),
                  child: BlockedUserCard(
                    block: userBlocks[index],
                    onUnblock: () {
                      _showUnblockConfirmation(
                        context,
                        userBlocks[index].id,
                        userBlocks[index].blockedId ?? 'this user',
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        if (state is BlockError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<BlockBloc>().add(
                        const GetBlocksEvent(type: 'user'),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showUnblockConfirmation(
    BuildContext context,
    int blockId,
    String userId,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Unblock User?'),
        content: const Text('Are you sure you want to unblock this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<BlockBloc>().add(UnblockByIdEvent(blockId: blockId));
            },
            child: const Text('Unblock'),
          ),
        ],
      ),
    );
  }
}

class BlockedCommunitiesTab extends StatelessWidget {
  const BlockedCommunitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlockActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<BlockBloc>().add(
            const GetBlocksEvent(type: 'community'),
          );
        } else if (state is BlockError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BlockLoading) {
          return const Center(child: SpinningScallopIndicator());
        }

        if (state is BlocksLoaded) {
          final communityBlocks = state.blocks
              .where((block) => block.blockType == 'community')
              .toList();

          if (communityBlocks.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lotties/organize.json",
                      height: 200,
                      repeat: false,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No blocked communities',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Communities you block will appear here',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<BlockBloc>().add(
                const GetBlocksEvent(type: 'community'),
              );
            },
            child: ListView.builder(
              itemCount: communityBlocks.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final block = communityBlocks[index];
                final communityId = int.tryParse(block.blockedId ?? '0');

                return BlocProvider(
                  create: (context) => CommunityHomeBloc(
                    getCommunityByIdUseCase: sl(),
                    deleteCommunityUseCase: sl(),
                    addCommunityGuidelinesUsecase: sl(),
                  )..add(FetchCommunityById(communityId: communityId ?? 0)),
                  child: BlocBuilder<CommunityHomeBloc, CommunityHomeState>(
                    builder: (context, communityState) {
                      String? communityImage;
                      String? communityName;
                      bool isLoading = communityState is CommunityHomeLoading;

                      if (communityState is CommunityHomeLoaded) {
                        communityImage =
                            communityState.community.profilePictureUrl;
                        communityName = communityState.community.name;
                      } else if (communityState is CommunityHomeFailure) {
                        communityName = 'Unknown Community';
                      }

                      return BlockedCommunityCard(
                        block: block,
                        communityName: communityName,
                        communityImage: communityImage,
                        isLoading: isLoading,
                        onUnblock: () {
                          _showUnblockConfirmation(
                            context,
                            block.id,
                            block.blockedId ?? 'this community',
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        if (state is BlockError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<BlockBloc>().add(
                        const GetBlocksEvent(type: 'community'),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showUnblockConfirmation(
    BuildContext context,
    int blockId,
    String communityId,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Unblock Community?'),
        content: const Text('Are you sure you want to unblock this community?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<BlockBloc>().add(UnblockByIdEvent(blockId: blockId));
            },
            child: const Text('Unblock'),
          ),
        ],
      ),
    );
  }
}

