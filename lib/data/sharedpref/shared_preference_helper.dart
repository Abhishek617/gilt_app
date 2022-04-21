import 'dart:async';
import 'dart:convert';

import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  //Auth Token
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }
  // Refresh Token
  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refresh_token);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.setString(Preferences.refresh_token, refreshToken);
  }

  Future<bool> removeRefreshToken() async {
    return _sharedPreference.remove(Preferences.refresh_token);
  }

  Future<String> get profileData async {
    return _sharedPreference.getString(Preferences.profileData) ?? '';
  }

  Future<bool> saveProfileData(GetProfileResponseModal profileData) async {
    return _sharedPreference.setString(
        Preferences.profileData, jsonEncode(profileData));
  }

  Future<bool> removeProfileData() async {
    return _sharedPreference.remove(Preferences.profileData);
  }

  Future<bool> get isFirst async {
    return _sharedPreference.getBool(Preferences.is_first_open) ?? true;
  }

  Future<bool> saveIsFirst(bool value) async {
    return _sharedPreference.setBool(Preferences.is_first_open, value);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }
  // User Role:---------------------------------------------------------------------
  Future<String> get userRole async {
    return _sharedPreference.getString(Preferences.userRole) ?? '1';
  }

  Future<bool> saveUserRole(String value) async {
    return _sharedPreference.setString(Preferences.userRole, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
