import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/domain/password_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordSignInForm extends StatefulWidget {
  const PasswordSignInForm({super.key});

  @override
  State<PasswordSignInForm> createState() => _PasswordSignInFormState();
}

class _PasswordSignInFormState extends State<PasswordSignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;
  bool _passwordLoginPending = false;
  String? _signInError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _passwordLoginPending = true;
      _signInError = null;
    });
    context.read<AuthBloc>().add(
      AuthSignInWithPasswordEvent(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          setState(() {
            _signInError = state.inline && _passwordLoginPending
                ? state.message
                : null;
            _passwordLoginPending = false;
          });
        } else if (state is AuthLoading && !_passwordLoginPending) {
          setState(() => _signInError = null);
        } else if (state is AuthAuthenticated || state is AuthUnauthenticated) {
          setState(() {
            _passwordLoginPending = false;
            _signInError = null;
          });
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final loading = state is AuthLoading;
          return AutofillGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteractionIfError,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: .emailAddress,
                    textInputAction: .next,
                    autofillHints: const [AutofillHints.email],
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: .all(.circular(8)),
                      ),
                      labelText: 'Email',
                      hintText: 'someone@example.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) return 'Enter your email address.';
                      if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                          .hasMatch(email)) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      if (_signInError != null) {
                        setState(() => _signInError = null);
                      }
                    },
                    onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: .visiblePassword,
                    textInputAction: .done,
                    autofillHints: const [AutofillHints.password],
                    autocorrect: false,
                    enableSuggestions: false,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: .all(.circular(8)),
                      ),

                      labelText: 'Password',
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
                    validator: (value) => PasswordPolicy.validate(value ?? ''),
                    onChanged: (_) {
                      if (_signInError != null) {
                        setState(() => _signInError = null);
                      }
                    },
                    onFieldSubmitted: (_) {
                      if (!loading) _submit();
                    },
                  ),
                  if (_signInError case final error?) ...[
                    const SizedBox(height: 10),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        error,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colors.error),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: loading ? null : _submit,
                    icon: loading
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.login),
                    label: Text(loading ? 'Signing in…' : 'Sign in with email'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Password sign-in is for existing accounts.'
                    ' If you use a linked Apple or Google account, '
                    'sign in with it and set a password in Profile settings.',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
