import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              title: Text("Discard changes?"),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                  },
                  child: const Text("Discard"),
                ),
              ],
            ),
          );
        }
      },
      child: BlocProvider.value(
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

  @override
  void initState() {
    super.initState();
    // Initialize controllers only for instructions that require input
    for (var instruction in widget.command.instructions.where(
      (i) => i.type == 'fill-form',
    )) {
      final key = instruction.valueKey ?? instruction.selectorToUse;
      _controllers[key] = TextEditingController(text: instruction.value ?? '');
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Breeze: Filter once and use this list for everything in the build method
    final fillInstructions = widget.command.instructions
        .where((i) => i.type == 'fill-form')
        .toList();

    return Form(
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

          // Use ListView.separated for clean, expressive spacing
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
              const SizedBox(width: 16),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.errorContainer,
                  foregroundColor: theme.colorScheme.error,
                  fixedSize: const Size(64, 64),
                  shape: const CircleBorder(),
                ),
                onPressed: _handleDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
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
        fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        labelText: instruction.inputLabel ?? key,
        prefixIcon: Icon(_getIconForInput(instruction.inputType)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
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
      // TODO: Add your Bloc Event here
    }
  }

  void _handleDelete() {
    // Clear all fields or trigger a deletion event
    _controllers.forEach((_, controller) => controller.clear());
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
