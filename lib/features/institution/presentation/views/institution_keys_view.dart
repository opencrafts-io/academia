import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionKeysView extends StatefulWidget {
  const InstitutionKeysView({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<InstitutionKeysView> createState() => _InstitutionKeysViewState();
}

class _InstitutionKeysViewState extends State<InstitutionKeysView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ScrappingCommandBloc>(),
      child: Scaffold(
        body: SheetContentScaffold(
          topBar: AppBar(
            centerTitle: true,
            title: const Text("Keys management"),
          ),
          body: SafeArea(
            minimum: .all(16),
            child: BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const _LoadingState(),
                  error: (message, command) => _ErrorState(message: message),
                  loaded: (command) => command == null
                      ? const InstitutionNotSupportedView()
                      : ScrappingCommandForm(
                          institutionID: widget.institutionID,
                          command: command,
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        const LoadingIndicatorM3E(),
        const SizedBox(height: 16),
        Text(
          "Loading institution information",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card.filled(
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(height: 12),
              Text(
                "We couldn't load your institution's setup details.",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontWeight: .bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrappingCommandForm extends StatefulWidget {
  final ScrappingCommand command;
  final int institutionID;
  const ScrappingCommandForm({
    super.key,
    required this.command,
    required this.institutionID,
  });

  @override
  State<ScrappingCommandForm> createState() => _ScrappingCommandFormState();
}

class _ScrappingCommandFormState extends State<ScrappingCommandForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _hasUnsavedChanges = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers only for instructions that require input
    for (var instruction in widget.command.instructions.where(
      (i) => i.type == 'fill-form',
    )) {
      final key = instruction.valueKey ?? instruction.selectorToUse;
      final controller = TextEditingController(text: instruction.value ?? '');

      // Add listener to track changes
      controller.addListener(() {
        if (!_hasUnsavedChanges) {
          setState(() => _hasUnsavedChanges = true);
        }
      });

      _controllers[key] = controller;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final institutionKeyState = context.read<InstitutionKeyBloc>().state;

    institutionKeyState.whenOrNull(
      loaded: (institutionKey) {
        final keySets = institutionKey?.keySets;

        if (keySets != null) {
          for (final entry in keySets.entries) {
            final key = entry.key;
            final value = entry.value;

            if (_controllers.containsKey(key)) {
              _controllers[key]?.text = value ?? '';
            }
          }
          // Reset unsaved changes flag after loading initial data
          _hasUnsavedChanges = false;
        }
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) {
      return true;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Text("Discard changes?"),
        content: const Text(
          "You have unsaved changes. Are you sure you want to leave?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text("Discard"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fillInstructions = widget.command.instructions
        .where((i) => i.type == 'fill-form')
        .toList();

    return BlocListener<InstitutionKeyBloc, InstitutionKeyState>(
      listener: (context, state) {
        // Only react while a save we triggered is actually in flight --
        // InstitutionKeyState.loaded also fires for the unrelated initial
        // key fetch that happens before this form is ever shown.
        if (!_isSaving) return;

        state.whenOrNull(
          loaded: (key) {
            _isSaving = false;
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: .floating,
                content: Text('Keys saved successfully'),
              ),
            );
            Navigator.of(context).pop();
          },
          error: (message, key) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: .floating,
                backgroundColor: theme.colorScheme.errorContainer,
                content: Text(
                  "Couldn't save your keys: $message",
                  style: TextStyle(color: theme.colorScheme.onErrorContainer),
                ),
              ),
            );
          },
        );
      },
      child: PopScope(
        canPop: !_hasUnsavedChanges,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          final shouldPop = await _onWillPop();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Secure sign-in",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Provide the following details to allow the system to "
                  "sync your data securely.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: fillInstructions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildExpressiveField(
                      context,
                      fillInstructions[index],
                    );
                  },
                ),

                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 64,
                        child: FilledButton.icon(
                          onPressed: _isSaving ? null : _handleSave,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          icon: _isSaving
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                )
                              : const Icon(Icons.check_circle_outline_rounded),
                          label: Text(_isSaving ? "Saving..." : "Save keys"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpressiveField(
    BuildContext context,
    ScrapingInstruction instruction,
  ) {
    final theme = Theme.of(context);
    final key = instruction.valueKey ?? instruction.selectorToUse;

    return TextFormField(
      controller: _controllers[key],
      obscureText: instruction.inputType == 'password',
      keyboardType: _getKeyboardType(instruction.inputType),
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        labelText: instruction.inputLabel ?? key,
        prefixIcon: Icon(_getIconForInput(instruction.inputType)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> updatedValues = _controllers.map(
        (key, controller) => MapEntry(key, controller.text),
      );

      final institutionKey = InstitutionKey(
        institutionId: widget.institutionID,
        commandId: widget.command.commandID!,
        keySets: updatedValues,
        createdAt: DateTime.now(),
      );

      setState(() {
        _isSaving = true;
        _hasUnsavedChanges = false;
      });

      context.read<InstitutionKeyBloc>().add(
        SaveInstitutionKeyEvent(key: institutionKey),
      );
    }
  }

  TextInputType _getKeyboardType(String? type) {
    switch (type) {
      case 'email':
        return .emailAddress;
      case 'number':
        return .number;
      default:
        return .text;
    }
  }

  IconData _getIconForInput(String? type) {
    switch (type) {
      case 'password':
        return Icons.key_outlined;
      case 'email':
        return Icons.alternate_email_rounded;
      case 'number':
        return Icons.numbers_rounded;
      default:
        return Icons.badge_outlined;
    }
  }
}
