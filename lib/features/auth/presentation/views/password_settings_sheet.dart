import 'package:academia/features/auth/domain/password_policy.dart';
import 'package:academia/features/auth/domain/usecases/set_password_usecase.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class PasswordSettingsSheet extends StatefulWidget {
  const PasswordSettingsSheet({required this.setPassword, super.key});

  final SetPasswordUsecase setPassword;

  @override
  State<PasswordSettingsSheet> createState() => _PasswordSettingsSheetState();
}

class _PasswordSettingsSheetState extends State<PasswordSettingsSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  final _confirmationFocusNode = FocusNode();
  bool _obscurePassword = true;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationController.dispose();
    _confirmationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _saving = true;
      _error = null;
    });

    final result = await widget.setPassword(_passwordController.text);
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _saving = false;
        _error = failure.message;
      }),
      (_) {
        setState(() => _saving = false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) context.pop(true);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final profileState = context.watch<ProfileBloc>().state;
    final accountEmail = profileState is ProfileLoadedState
        ? profileState.profile.email.trim()
        : '';

    final sheetContent = SheetContentScaffold(
      extendBodyBehindBottomBar: false,
      topBar: AppBar(
        title: const Text('Set or change password'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (accountEmail.isNotEmpty) ...[
                        Text('This password will sign in to $accountEmail.'),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.newPassword],
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'New password',
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),

                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword
                                ? 'Show password'
                                : 'Hide password',
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            PasswordPolicy.validate(value ?? ''),
                        onChanged: (_) {
                          if (_error != null) setState(() => _error = null);
                        },
                        onFieldSubmitted: (_) =>
                            _confirmationFocusNode.requestFocus(),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmationController,
                        focusNode: _confirmationFocusNode,
                        keyboardType: .visiblePassword,
                        textInputAction: .done,
                        autofillHints: const [AutofillHints.newPassword],
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: _obscurePassword,
                        decoration: const InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'The passwords do not match.';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          if (_error != null) setState(() => _error = null);
                        },
                        onFieldSubmitted: (_) => _save(),
                      ),
                      if (_error case final error?) ...[
                        const SizedBox(height: 12),
                        Semantics(
                          liveRegion: true,
                          child: Text(
                            error,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.error),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Text(
                        'If you cannot sign in with a password, '
                        'use your linked OAuth provider and set a new password here.',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return SheetPopScope<bool>(canPop: !_saving, child: sheetContent);
  }
}
