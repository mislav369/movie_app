import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:movie_app/presentation/auth/widget/custom_text_field.dart';
import 'package:movie_app/presentation/core/app_router.dart';
import 'package:movie_app/presentation/core/widget/app_snackbar.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController(
  );

  final _passwordController = TextEditingController(
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;

    if (!valid) {
      return;
    }

    ref.read(authenticationNotifierProvider.notifier).signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(
      authenticationNotifierProvider,
          (previous, next) {
        if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

        if (next is AuthenticationSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.home,
                (route) => false,
          );
        }

        if (next is AuthenticationErrorState) {
          showErrorSnackBar(context, next.message);
        }
      },
    );

    final state = ref.watch(authenticationNotifierProvider);
    final isLoading = state is AuthenticationLoadingState;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 64,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/sign_in_img.png',
                    width: 380,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Movie App',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please sign in to your account',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final email = value?.trim() ?? '';

                      if (email.isEmpty) {
                        return 'Email is required.';
                      }

                      if (!email.contains('@')) {
                        return 'Enter a valid email.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      final password = value ?? '';

                      if (password.isEmpty) {
                        return 'Password is required.';
                      }

                      if (password.length < 8) {
                        return 'Password must have at least 8 characters.';
                      }

                      if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
                        return 'Password must include a letter.';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(password)) {
                        return 'Password must include a number.';
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
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Sign in'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRouter.register),
                        child: Text(
                          'Sign up',
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