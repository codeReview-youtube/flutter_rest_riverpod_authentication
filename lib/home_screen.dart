import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_tutorials/storage_state.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          const Text(
            'Home Screen',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ref.watch(getAuthenticatedUserProvider).when(
                  loading: () => const CircularProgressIndicator(),
                  data: (email) => Text(email),
                  error: (error, stackTrace) {
                    debugPrint(error.toString());
                    return const Text('User information is not available!');
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isCleared = await ref.read(resetStorage);
          if (isCleared) {
            // ignore: use_build_context_synchronously
            Navigator.popAndPushNamed(context, 'Login');
          }
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
