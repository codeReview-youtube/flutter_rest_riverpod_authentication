import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_tutorials/home_screen.dart';
import 'package:riverpod_tutorials/login_screen.dart';
import 'package:riverpod_tutorials/storage_state.dart';

final tempProvider = FutureProvider(
  (_) => Future.delayed(
    const Duration(seconds: 1),
    () => true,
  ),
);
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Riverpod Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ref
          .watch(
            getAuthStorage,
          )
          .when(
            data: (bool isAuthenticated) =>
                isAuthenticated ? const HomeScreen() : const LoginScreen(),
            loading: () {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stacktrace) => const LoginScreen(),
          ),
      routes: {
        "Home": (context) => const HomeScreen(),
        "Login": (context) => const LoginScreen(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref
            .watch(
              getAuthStorage,
            )
            .when(
              data: (bool isAuthenticated) {
                // Print to console
                print('MainScaffold: $isAuthenticated');
                return isAuthenticated
                    ? const HomeScreen()
                    : const LoginScreen();
              },
              loading: () {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              error: (error, stacktrace) => const LoginScreen(),
            );
      },
    );
  }
}
