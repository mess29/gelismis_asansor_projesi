import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelismis_asansor_projesi/src/data/models/user_profile.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
class Profile extends _$Profile {
  @override
  FutureOr<UserProfile?> build() async {
    return _loadProfile();
  }

  Future<UserProfile?> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('user_profile');
    if (profileJson != null) {
      try {
        final decoded = jsonDecode(profileJson) as Map<String, dynamic>;
        return UserProfile.fromJson(decoded);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> updateProfile(UserProfile newProfile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', jsonEncode(newProfile.toJson()));
      return newProfile;
    });
  }

  Future<void> clearProfile() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_profile');
      return null;
    });
  }
}
