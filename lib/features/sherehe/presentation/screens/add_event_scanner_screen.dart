import 'dart:async';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventScannerScreen extends StatefulWidget {
  final String eventId;

  const AddEventScannerScreen({super.key, required this.eventId});

  @override
  State<AddEventScannerScreen> createState() => _AddEventScannerScreenState();
}

class _AddEventScannerScreenState extends State<AddEventScannerScreen> {
  final _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  void _confirmAddScanner({
    required BuildContext context,
    required String userId,
    required String userName,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Scanner"),
        content: Text("Make $userName a scanner for this event?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          BlocBuilder<AddScannerBloc, AddScannerState>(
            builder: (context, state) {
              return state is AddScannerStateLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    )
                  : FilledButton(
                      onPressed: () {
                        context.read<AddScannerBloc>().add(
                          AddScanner(eventId: widget.eventId, userId: userId),
                        );
                      },
                      child: const Text("Confirm"),
                    );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddScannerBloc, AddScannerState>(
      listener: (context, state) {
        if (state is AddScannerSuccess) {
          context.read<AllScannersBloc>().add(
            FetchAllScanners(eventId: widget.eventId, page: 1, limit: 20),
          );
          Navigator.pop(context); // close dialog
          Navigator.pop(context); // close screen

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Scanner added successfully"),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        if (state is AddScannerStateError) {
          Navigator.pop(context); // close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(pinned: true, title: const Text("Add Scanner")),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: SearchBar(
                  controller: _searchController,
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  hintText: "Search by username or email",
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    _debounce?.cancel();

                    _debounce = Timer(const Duration(milliseconds: 450), () {
                      final query = value.trim();
                      if (query.isNotEmpty) {
                        context.read<AddScannerBloc>().add(
                          SearchUser(query: query),
                        );
                      }
                    });
                  },
                  trailing: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _debounce?.cancel();
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            ),

            BlocBuilder<AddScannerBloc, AddScannerState>(
              builder: (context, state) {
                if (state is SearchUserLoading) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: SpinningScallopIndicator()),
                  );
                }

                if (state is SearchUserFailure) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(state.message)),
                  );
                }

                if (state is SearchUserSuccess) {
                  if (state.users.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_search_outlined, size: 64),
                            SizedBox(height: 12),
                            Text(
                              "No users found",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final user = state.users[index];

                      return UserTile(
                        name: user.username ?? "Guest",
                        subtitle: user.email,
                        icon: Icons.person_outline,
                        onTap: () => _confirmAddScanner(
                          context: context,
                          userId: user.id,
                          userName: user.username ?? "Guest",
                        ),
                      );
                    }, childCount: state.users.length),
                  );
                }

                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search, size: 64),
                        SizedBox(height: 12),
                        Text("Search for a user to add as scanner"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
