import 'package:academia/features/communities/domain/entities/community_moderation_enum.dart';
import 'package:academia/features/communities/presentation/bloc/add_members_bloc.dart';
import 'package:academia/features/communities/presentation/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMembersScreen extends StatefulWidget {
  final String communityId;
  final String userId;

  const AddMembersScreen({
    super.key,
    required this.communityId,
    required this.userId,
  });

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  String _query = "";
  late final TextEditingController _controller;
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMembersBloc, AddMembersState>(
      listener: (context, state) {
        if (state is MemberAddedSuccess) {
          // Pop back and return updated community
          Navigator.pop(context, state.community);
        }
        if (state is AddMembersFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is SearchResultsLoaded) {
          setState(() => _isSearching = false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                pinned: true,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text("Add Members"),
              ),

              // Search bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? _isSearching
                                ? const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _controller.clear();
                                      setState(() {
                                        _query = "";
                                        _isSearching = false;
                                      });
                                    },
                                  )
                          : null,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _query = val;
                        _isSearching = val.isNotEmpty;
                      });
                      if (val.isNotEmpty) {
                        _debouncer.run(() {
                          context.read<AddMembersBloc>().add(SearchUsers(val));
                        });
                      }
                    },
                  ),
                ),
              ),

              // Body
              if (state is AddMembersLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is SearchResultsLoaded)
                SliverList.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name[0].toUpperCase()),
                      ),
                      title: Text(user.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.person_add),
                        onPressed: () {
                          context.read<AddMembersBloc>().add(
                            AddMemberToCommunity(
                              communityId: widget.communityId,
                              action: CommunityModerationAction.addMember,
                              userId: widget.userId,
                              memberId: user.id,
                              memberName: user.name,
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              else if (state is AddMembersFailure)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.message)),
                )
              else
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text("Search for users")),
                ),
            ],
          ),
        );
      },
    );
  }
}
