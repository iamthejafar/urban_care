import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_care/src/utils/user_preferences.dart';
import '../../../../utils/dependency_injection.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecase/get_user.dart';

enum UserState { initial, loading, loaded, error }

class UserNotifier extends StateNotifier<UserState> {
  final GetUserUseCase getUserUseCase;
  UserEntity? _user;

  UserNotifier(this.getUserUseCase) : super(UserState.initial) {
    fetchUser(uid: UserPreferences.userId);
  }

  UserEntity? get user => _user;

  Future<void> fetchUser({required String uid}) async {
    state = UserState.loading;
    try {
      final fetchedUser = await getUserUseCase.call(GetUserParams(uid: uid));
      _user = fetchedUser;
      state = UserState.loaded;

      if (_user != null) {
        UserPreferences.setUser(
            userId: _user!.uid,
            userName: _user!.name,
            email: _user!.email,
            profilePic: _user!.profilePicUrl,
            currentStreak: _user!.currentStreak,
            longestStreak: _user!.longestStreak);
      }
      if (kDebugMode) {
        print(_user);
      }
    } catch (e) {
      state = UserState.error;
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return locator<UserNotifier>();
});
