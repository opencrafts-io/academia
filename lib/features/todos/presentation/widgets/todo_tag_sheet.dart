import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoTagSheet extends StatefulWidget {
  const TodoTagSheet({
    super.key,
    required this.selectedTags,
    required this.onChanged,
  });
  final List<TodoTagEntity> selectedTags;
  final ValueChanged<List<TodoTagEntity>> onChanged;

  @override
  State<TodoTagSheet> createState() => _TodoTagSheetState();
}

class _TodoTagSheetState extends State<TodoTagSheet> {
  late List<TodoTagEntity> _selected;
  final _newTagController = TextEditingController();
  bool _showCreateField = false;
  Color _newTagColor = const Color(0xFF0061A4);

  static const _swatchColors = [
    Color(0xFF0061A4),
    Color(0xFF9C4DFF),
    Color(0xFF00B37E),
    Color(0xFFFF5A5F),
    Color(0xFFFF9A00),
    Color(0xFF00A3FF),
    Color(0xFFFF3D00),
    Color(0xFFB00020),
  ];

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedTags);
  }

  @override
  void dispose() {
    _newTagController.dispose();
    super.dispose();
  }

  void _toggleTag(TodoTagEntity tag) {
    setState(() {
      if (_selected.any((t) => t.localId == tag.localId)) {
        _selected.removeWhere((t) => t.localId == tag.localId);
      } else {
        _selected.add(tag);
      }
    });
    widget.onChanged(_selected);
  }

  void _createTag() {
    final name = _newTagController.text.trim();
    if (name.isEmpty) return;

    final hex =
        '#${_newTagColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    context.read<TodoTagCubit>().createTag(
      TodoTagEntity(
        localId: 0,
        name: name,
        color: hex,
        syncStatus: SyncStatus.pending,
        isPendingDeletion: false,
        isDirty: true,
      ),
    );

    _newTagController.clear();
    setState(() => _showCreateField = false);
  }

  Color _tagColor(TodoTagEntity tag, ColorScheme scheme) {
    if (tag.color == null) return scheme.primary;
    final hex = tag.color!.replaceFirst('#', '');
    final parsed = int.tryParse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
    return parsed != null ? Color(parsed) : scheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Tags",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () =>
                    setState(() => _showCreateField = !_showCreateField),
                icon: Icon(
                  _showCreateField ? Icons.close : Icons.add,
                  size: 16,
                ),
                label: Text(_showCreateField ? "Cancel" : "New tag"),
              ),
            ],
          ),

          if (_showCreateField) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                // Color swatch picker
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Pick a color"),
                        content: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _swatchColors.map((c) {
                            return GestureDetector(
                              onTap: () {
                                setState(() => _newTagColor = c);
                                Navigator.pop(context);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: _newTagColor == c
                                      ? Border.all(
                                          color: scheme.onSurface,
                                          width: 3,
                                        )
                                      : null,
                                ),
                                child: _newTagColor == c
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _newTagColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _newTagColor.withAlpha(100),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _newTagController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Tag name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _createTag(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _createTag, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 4),

          BlocBuilder<TodoTagCubit, TodoTagState>(
            builder: (context, state) {
              final tags = state.currentTags;

              if (tags.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.label_outline,
                          size: 40,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "No tags yet",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Tap 'New tag' to create one",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    final isSelected = _selected.any(
                      (t) => t.localId == tag.localId,
                    );
                    final color = _tagColor(tag, scheme);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withAlpha(30),
                        radius: 16,
                        child: Icon(Icons.circle, color: color, size: 10),
                      ),
                      title: Text(tag.name),
                      trailing: isSelected
                          ? Icon(Icons.check_circle_rounded, color: color)
                          : Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: scheme.outlineVariant,
                            ),
                      onTap: () => _toggleTag(tag),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
