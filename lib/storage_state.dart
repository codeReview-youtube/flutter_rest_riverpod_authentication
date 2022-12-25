import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_tutorials/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const IS_AUTHENTICATED_KEY = 'IS_AUTHENTICATED_KEY';
// ignore: constant_identifier_names
const AUTHENTICATED_USER_EMAIL_KEY = 'AUTHENTICATED_USER_EMAIL_KEY';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

final setAuthStateProvider = StateProvider<AuthResponse?>(
  (ref) => null,
);

final setIsAuthenticatedProvider = StateProvider.family<void, bool>(
  (ref, isAuth) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    prefs.setBool(
      IS_AUTHENTICATED_KEY,
      isAuth,
    );
  },
);

final setAuthenticatedUserProvider = StateProvider.family<void, String>(
  (ref, email) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    prefs.setString(
      AUTHENTICATED_USER_EMAIL_KEY,
      email,
    );
  },
);

final getIsAuthenticatedProvider = FutureProvider<bool>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    return prefs.getBool(IS_AUTHENTICATED_KEY) ?? false;
  },
);

final getAuthenticatedUserProvider = FutureProvider<String>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    return prefs.getString(AUTHENTICATED_USER_EMAIL_KEY) ?? '';
  },
);
// Todo: Handle logout or and reset
final resetStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    final isCleared = await prefs.clear();
    return isCleared;
  },
);
