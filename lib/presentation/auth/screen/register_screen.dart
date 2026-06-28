import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:movie_app/presentation/auth/widget/custom_text_field.dart';
import 'package:movie_app/presentation/core/app_router.dart';
import 'package:movie_app/presentation/core/widget/app_snackbar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authenticationNotifierProvider.notifier).signUp(
        _email.text.trim(),
        _password.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(authenticationNotifierProvider, (previous, next) {
      if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

      if (next is AuthenticationSuccessState) {
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false);
      }
      if (next is AuthenticationErrorState) {
        showErrorSnackBar(context, next.message);
      }
    });

    final state = ref.watch(authenticationNotifierProvider);
    final isLoading = state is AuthenticationLoadingState;

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/sign_in_img.png', width: 290),
                  const SizedBox(height: 16),
                  Text(
                    'Create your account',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _email,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) return 'Email is required.';
                      if (!email.contains('@')) return 'Enter a valid email.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _password,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      final p = value ?? '';
                      if (p.isEmpty) return 'Password is required.';
                      if (p.length < 8) {
                        return 'Password must have at least 8 characters.';
                      }
                      if (!RegExp(r'[A-Za-z]').hasMatch(p)) {
                        return 'Password must include a letter.';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(p)) {
                        return 'Password must include a number.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _confirm,
                    label: 'Confirm password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if ((value ?? '') != _password.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Sign up'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}