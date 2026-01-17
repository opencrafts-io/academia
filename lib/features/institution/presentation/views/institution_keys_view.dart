import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionKeysView extends StatefulWidget {
  const InstitutionKeysView({super.key});

  @override
  State<InstitutionKeysView> createState() => _InstitutionKeysViewState();
}

class _InstitutionKeysViewState extends State<InstitutionKeysView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ScrappingCommandBloc>(),
      child: SheetContentScaffold(
        topBar: AppBar(centerTitle: true, title: Text("Keys management")),
        body: SafeArea(
          minimum: EdgeInsets.all(16),
          child: BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
            builder: (context, state) {
              if (state is ScrappingCommandLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadingIndicatorM3E(),
                    SizedBox(height: 12),
                    Text("Loading institution information"),
                  ],
                );
              } else if (state is ScrappingCommandError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Holy molly ..."),
                    SizedBox(height: 12),
                    Text(state.message),
                  ],
                );
              } else if (state is ScrappingCommandInitial) {
                return SizedBox.shrink();
              }

              return (state as ScrappingCommandLoaded).command == null
                  ? InstitutionNotSupportedView()
                  : ScrappingCommandForm(command: state.command!);
            },
          ),
        ),
      ),
    );
  }
}

class ScrappingCommandForm extends StatefulWidget {
  final ScrappingCommand command;
  const ScrappingCommandForm({super.key, required this.command});

  @override
  State<ScrappingCommandForm> createState() => _ScrappingCommandFormState();
}

class _ScrappingCommandFormState extends State<ScrappingCommandForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _hasUnsavedChanges = false;
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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

    if (institutionKeyState is InstitutionKeyLoaded) {
      final keySets = institutionKeyState.key?.keySets;

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
    }
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
        title: Text("Discard changes?"),
        content: Text(
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

    return PopScope(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Provide the following details to allow the system to sync your data securely.",
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
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildExpressiveField(context, fillInstructions[index]);
              },
            ),

            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 64,
                    child: FilledButton(
                      onPressed: _handleSave,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text("Save keys"),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          alpha: 50,
        ),
        labelText: instruction.inputLabel ?? key,
        prefixIcon: Icon(_getIconForInput(instruction.inputType)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
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
        institutionId: 5426,
        commandId: widget.command.commandID!,
        keySets: updatedValues,
        createdAt: DateTime.now(),
      );

      context.read<InstitutionKeyBloc>().add(
        SaveInstitutionKeyEvent(key: institutionKey),
      );

      // Reset unsaved changes flag
      setState(() => _hasUnsavedChanges = false);

      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Keys saved successfully'),
        ),
      );
    }
  }

  TextInputType _getKeyboardType(String? type) {
    switch (type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'number':
        return TextInputType.number;
      default:
        return TextInputType.text;
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
