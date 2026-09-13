import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:academia/features/chirp/posts/presentation/utils/poll_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Opens the poll builder as a modal sheet. Resolves with a normalized
/// [PollDraft] when the user taps "Done", or null when dismissed.
Future<PollDraft?> showCreatePollSheet(
  BuildContext context, {
  PollDraft? initial,
}) {
  return showModalBottomSheet<PollDraft>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CreatePollSheet(initial: initial),
  );
}

class CreatePollSheet extends StatefulWidget {
  final PollDraft? initial;

  const CreatePollSheet({super.key, this.initial});

  @override
  State<CreatePollSheet> createState() => _CreatePollSheetState();
}

class _OptionField {
  final Key key = UniqueKey();
  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  _OptionField([String text = ''])
    : controller = TextEditingController(text: text);

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}

class _CreatePollSheetState extends State<CreatePollSheet> {
  late final TextEditingController _questionController;
  final List<_OptionField> _options = [];
  bool _allowsMultiple = false;
  bool _isAnonymous = false;
  DateTime? _endsAt;

  /// Empty-field errors are noisy while typing, so they only show after the
  /// first submit attempt. Duplicate errors are shown live.
  bool _attemptedSubmit = false;

  List<PollValidationError> _errors = const [];

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _questionController = TextEditingController(text: initial?.question ?? '');
    _questionController.addListener(_revalidate);
    final seed = initial?.options ?? const ['', ''];
    for (final text in seed) {
      _addOptionField(text, revalidate: false);
    }
    while (_options.length < PollValidator.minOptions) {
      _addOptionField('', revalidate: false);
    }
    _allowsMultiple = initial?.allowsMultiple ?? false;
    _isAnonymous = initial?.isAnonymous ?? false;
    _endsAt = initial?.endsAt;
    _revalidate();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final o in _options) {
      o.dispose();
    }
    super.dispose();
  }

  PollDraft get _draft => PollDraft(
    question: _questionController.text,
    options: _options.map((o) => o.controller.text).toList(),
    allowsMultiple: _allowsMultiple,
    isAnonymous: _isAnonymous,
    endsAt: _endsAt,
  );

  void _revalidate() {
    if (!mounted) return;
    setState(() => _errors = PollValidator.validate(_draft));
  }

  _OptionField _addOptionField(String text, {bool revalidate = true}) {
    final field = _OptionField(text);
    field.controller.addListener(_revalidate);
    _options.add(field);
    if (revalidate) _revalidate();
    return field;
  }

  void _addOption() {
    if (_options.length >= PollValidator.maxOptions) return;
    final field = _addOptionField('');
    // Let the new row build before requesting focus.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) field.focusNode.requestFocus();
    });
  }

  void _removeOption(int index) {
    if (_options.length <= PollValidator.minOptions) return;
    final removed = _options.removeAt(index);
    removed.controller.removeListener(_revalidate);
    _revalidate();
    // The row's TextField is still mounted until the rebuild above lands;
    // dispose its controller/focus node only once it's gone.
    WidgetsBinding.instance.addPostFrameCallback((_) => removed.dispose());
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _options.removeAt(oldIndex);
      _options.insert(newIndex, item);
    });
  }

  Future<void> _pickEndsAt() async {
    final now = DateTime.now();
    final initial = _endsAt ?? now.add(const Duration(days: 1));
    final date = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(now) ? now : initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (!mounted) return;
    setState(() {
      _endsAt = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? initial.hour,
        time?.minute ?? initial.minute,
      );
    });
    _revalidate();
  }

  void _submit() {
    setState(() => _attemptedSubmit = true);
    _revalidate();
    if (_errors.isNotEmpty) {
      // Jump focus to the first broken option so the user sees the error.
      final firstOption = _errors
          .where((e) => e.field == PollField.option)
          .map((e) => e.optionIndex)
          .whereType<int>()
          .firstOrNull;
      if (firstOption != null && firstOption < _options.length) {
        _options[firstOption].focusNode.requestFocus();
      }
      return;
    }
    Navigator.of(context).pop(PollValidator.normalize(_draft));
  }

  /// Which errors to surface inline right now.
  String? _errorFor(PollField field, {int? optionIndex}) {
    final message = PollValidator.messageFor(
      _errors,
      field,
      optionIndex: optionIndex,
    );
    if (message == null) return null;
    final isLive = message.startsWith('Duplicate') || field == PollField.endsAt;
    return (_attemptedSubmit || isLive) ? message : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final canAdd = _options.length < PollValidator.maxOptions;
    final canRemove = _options.length > PollValidator.minOptions;
    final optionsError = _attemptedSubmit
        ? PollValidator.messageFor(_errors, PollField.options)
        : null;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.poll_outlined, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(
                      widget.initial == null ? 'Create poll' : 'Edit poll',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          controller: _questionController,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: PollValidator.maxQuestionLength,
                          maxLines: 3,
                          minLines: 1,
                          style: theme.textTheme.titleMedium,
                          decoration: InputDecoration(
                            labelText: 'Question',
                            hintText: 'Ask the community something…',
                            errorText: _errorFor(PollField.question),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Text(
                              'Options',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${_options.length}/${PollValidator.maxOptions}',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (optionsError != null)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            optionsError,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      sliver: SliverReorderableList(
                        itemCount: _options.length,
                        onReorder: _reorder,
                        itemBuilder: (context, index) {
                          final option = _options[index];
                          return _OptionRow(
                            key: option.key,
                            index: index,
                            controller: option.controller,
                            focusNode: option.focusNode,
                            errorText: _errorFor(
                              PollField.option,
                              optionIndex: index,
                            ),
                            canRemove: canRemove,
                            onRemove: () => _removeOption(index),
                            onSubmitted: () {
                              if (index == _options.length - 1) {
                                if (canAdd) _addOption();
                              } else {
                                _options[index + 1].focusNode.requestFocus();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: canAdd ? _addOption : null,
                            icon: const Icon(Icons.add),
                            label: const Text('Add option'),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: Divider()),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SwitchListTile.adaptive(
                            value: _allowsMultiple,
                            onChanged: (v) =>
                                setState(() => _allowsMultiple = v),
                            secondary: const Icon(Icons.checklist_rounded),
                            title: const Text('Allow multiple choices'),
                            subtitle: const Text(
                              'Voters can pick more than one option',
                            ),
                          ),
                          SwitchListTile.adaptive(
                            value: _isAnonymous,
                            onChanged: (v) => setState(() => _isAnonymous = v),
                            secondary: const Icon(
                              Icons.visibility_off_outlined,
                            ),
                            title: const Text('Anonymous votes'),
                            subtitle: const Text(
                              'Only you can see who voted for what',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.timer_outlined),
                            title: const Text('End time'),
                            subtitle: Text(
                              _endsAt == null
                                  ? 'No end time — poll stays open'
                                  : DateFormat(
                                      'EEE, d MMM yyyy • HH:mm',
                                    ).format(_endsAt!),
                              style: _errorFor(PollField.endsAt) != null
                                  ? TextStyle(color: colorScheme.error)
                                  : null,
                            ),
                            trailing: _endsAt == null
                                ? const Icon(Icons.chevron_right)
                                : IconButton(
                                    tooltip: 'Remove end time',
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() => _endsAt = null);
                                      _revalidate();
                                    },
                                  ),
                            onTap: _pickEndsAt,
                          ),
                          if (_errorFor(PollField.endsAt) != null)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(72, 0, 20, 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _errorFor(PollField.endsAt)!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  12 + MediaQuery.viewInsetsOf(context).bottom,
                ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(top: BorderSide(color: theme.dividerColor)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _submit,
                    icon: const Icon(Icons.check),
                    label: Text(
                      widget.initial == null ? 'Add poll to post' : 'Save poll',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionRow extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorText;
  final bool canRemove;
  final VoidCallback onRemove;
  final VoidCallback onSubmitted;

  const _OptionRow({
    super.key,
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.errorText,
    required this.canRemove,
    required this.onRemove,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReorderableDragStartListener(
            index: index,
            child: Padding(
              padding: const EdgeInsets.only(top: 14, left: 4, right: 4),
              child: Icon(
                Icons.drag_indicator,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              maxLength: PollValidator.maxOptionLength,
              onSubmitted: (_) => onSubmitted(),
              decoration: InputDecoration(
                hintText: 'Option ${index + 1}',
                errorText: errorText,
                counterText: '',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: canRemove
                ? 'Remove option'
                : 'A poll needs at least 2 options',
            onPressed: canRemove ? onRemove : null,
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }
}

/// Compact summary of a [PollDraft] shown in the Add Post screen once a poll
/// has been attached, with edit/remove affordances.
class PollDraftPreview extends StatelessWidget {
  final PollDraft draft;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const PollDraftPreview({
    super.key,
    required this.draft,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.poll_outlined,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      draft.question,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit poll',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    tooltip: 'Remove poll',
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.delete_outline, color: colorScheme.error),
                    onPressed: onRemove,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final option in draft.options)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(option, style: theme.textTheme.bodyMedium),
                  ),
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  _chip(
                    context,
                    draft.allowsMultiple ? 'Multiple choice' : 'Single choice',
                    draft.allowsMultiple
                        ? Icons.checklist_rounded
                        : Icons.radio_button_checked,
                  ),
                  if (draft.isAnonymous)
                    _chip(context, 'Anonymous', Icons.visibility_off_outlined),
                  if (draft.endsAt != null)
                    _chip(
                      context,
                      'Ends ${DateFormat('d MMM, HH:mm').format(draft.endsAt!)}',
                      Icons.timer_outlined,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(icon, size: 16, color: colorScheme.onSecondaryContainer),
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.labelSmall,
      backgroundColor: colorScheme.secondaryContainer,
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
