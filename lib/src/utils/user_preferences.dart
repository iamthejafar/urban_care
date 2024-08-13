



import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _userId = 'userId';
  static const _userName = 'user_name';
  static const _email = "email";
  static const _profilePic = 'profile_pic';
  static const _longestStreak = "longest_streak";
  static const _currentStreak = "current_streak";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser({
    required String userId,
    required String userName,
    required String email,
    String? profilePic,
    int? currentStreak,
    int? longestStreak
  }) async {
    await _preferences.setString(_userId, userId);
    await _preferences.setString(_userName, userName);
    await _preferences.setString(_email, email);
    await _preferences.setString(_profilePic, profilePic ?? "");

    await _preferences.setInt(_currentStreak, currentStreak ?? 0);
    await _preferences.setInt(_longestStreak, longestStreak ?? 0);
  }
  static Future setUserName(String? userName) async {
    await _preferences.setString(_userName, userName ?? "");
  }

  static Future setProfilePic(String profilePic) async {
    await _preferences.setString(_profilePic, profilePic);
  }


  static String get userId => _preferences.getString(_userId) ?? "";
  static String get userName => _preferences.getString(_userName) ?? "";
  static String get email => _preferences.getString(_email) ?? "";
  static String? get profilePic => _preferences.getString(_profilePic);
  static int get currentStreak => _preferences.getInt(_currentStreak) ?? 0;
  static int get longestStreak => _preferences.getInt(_longestStreak) ?? 0;



  static Future removeProfile() async {
    await _preferences.remove(_profilePic);
  }

  static Future removeUser() async {
    await _preferences.remove(_userId);
    await _preferences.remove(_userName);
    await _preferences.remove(_profilePic);
  }
}
