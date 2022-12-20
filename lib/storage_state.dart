import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const STORAGE_KEY = 'AUTHENTICATION_STATUS';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

final setAuthStateProvider = StateProvider<dynamic>(
  (ref) => null,
);

final setAuthStorage =
    StateProvider.family<void, bool>((ref, isAuthenticated) async {
  final prefs = await ref.watch(sharedPrefProvider);
  ref.watch(setAuthStateProvider); // watch the privider in case of any change.
  prefs.setBool(STORAGE_KEY, isAuthenticated);
});

final getAuthStorage = FutureProvider<bool>((ref) async {
  final prefs = await ref.watch(sharedPrefProvider);
  ref.watch(setAuthStateProvider);
  return prefs.getBool(STORAGE_KEY) ?? false;
});
// Todo: Handle logout or and reset
final resetStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    prefs.clear();
  },
);
