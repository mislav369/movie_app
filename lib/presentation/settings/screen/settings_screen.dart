import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/presentation/core/app_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmClearLibrary(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear library?'),
          content: const Text(
            'This will remove all favorites and watchlist movies.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await ref.read(libraryNotifierProvider.notifier).clear();
    }
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(userRepositoryProvider).currentUser?.email ?? 'Unknown';
    final themeMode = ref.watch(themeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _sectionHeader(context, 'Account'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text(
              'Signed in as',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(email),
          ),

          _sectionHeader(context, 'Preferences'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text(
              'Dark theme',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            value: isDark,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggle(value);
            },
          ),

          _sectionHeader(context, 'Options'),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text(
              'Clear library',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Remove all favorites and watchlist'),
            onTap: () => _confirmClearLibrary(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sign out',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () async {
              await ref.read(userSignOutUseCaseProvider)();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.signIn,
                      (route) => false,
                );
              }
            },
          ),

        ],
      ),
    );
  }
}