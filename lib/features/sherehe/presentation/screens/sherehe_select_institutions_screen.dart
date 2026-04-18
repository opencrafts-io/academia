import 'dart:async';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/institution/presentation/bloc/institution_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShereheSelectInstitutionsScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Institution> selectedInstitutions;

  const ShereheSelectInstitutionsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedInstitutions,
  });

  @override
  State<ShereheSelectInstitutionsScreen> createState() =>
      _ShereheSelectInstitutionsScreenState();
}

class _ShereheSelectInstitutionsScreenState
    extends State<ShereheSelectInstitutionsScreen> {
  late List<Institution> _selectedInstitutions;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _search = "";

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _search = value;

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (_search.trim().isNotEmpty) {
        context.read<InstitutionBloc>().add(
          SearchInstitutionByNameEvent(_search.trim()),
        );
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _selectedInstitutions = List.from(widget.selectedInstitutions);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _selectedInstitutions.isEmpty
                  ? null
                  : () {
                      context.pop(_selectedInstitutions);
                    },
              child: Text("Done Selecting (${_selectedInstitutions.length})"),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text("Select Institutions"),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Search institutions...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _search = "");
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          if (_selectedInstitutions.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: _selectedInstitutions.map((inst) {
                    return Chip(
                      label: Text(inst.name),
                      onDeleted: () {
                        setState(() => _selectedInstitutions.remove(inst));
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          BlocBuilder<InstitutionBloc, InstitutionState>(
            builder: (context, state) {
              if (state is InstitutionLoadingState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: const Center(child: SpinningScallopIndicator()),
                );
              }

              if (state is InstitutionErrorState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      state.error,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                );
              }

              if (state is InstitutionLoadedState) {
                if (state.institutions.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off, size: 48),
                          SizedBox(height: 8),
                          Text("No results found"),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final institution = state.institutions[index];
                    final selected = _selectedInstitutions.any(
                      (e) => e.institutionId == institution.institutionId,
                    );

                    return CheckboxListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Text(institution.name),
                      value: selected,
                      onChanged: (val) => setState(() {
                        if (val == true) {
                          _selectedInstitutions.add(institution);
                        } else {
                          _selectedInstitutions.removeWhere(
                            (e) => e.institutionId == institution.institutionId,
                          );
                        }
                      }),
                    );
                  }, childCount: state.institutions.length),
                );
              }

              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.school_outlined, size: 70),
                      SizedBox(height: 10),
                      Text(
                        "Start by searching for an institution",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
