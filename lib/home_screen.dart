import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_tutorials/auth_state.dart';
import 'package:riverpod_tutorials/storage_state.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(authenticationHandlerProvider, (prev, next) {

    // });
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
            child: Consumer(
              builder: (context, ref, child) {
                final email =
                    ref.watch(authenticationHandlerProvider).authValues.email;
                return Text(
                  'Welcome $email',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(setAuthStateProvider.notifier).state = null;
          ref.read(resetStorage);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
