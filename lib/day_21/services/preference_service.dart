import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class PreferenceService {
  static late SharedPreferences prefs;

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    final isDark = isDarkMode();
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // Auth Token
  static Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  static String? getToken() {
    return prefs.getString('token');
  }

  // User Profile Cache
  static Future<void> saveUser(UserModel user) async {
    await prefs.setString('user_data', jsonEncode(user.toJson()));
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
  }

  static UserModel? getUser() {
    final raw = prefs.getString('user_data');
    if (raw != null) {
      try {
        final Map<String, dynamic> map = jsonDecode(raw);
        return UserModel.fromJson(map);
      } catch (_) {}
    }
    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');
    if (name != null || email != null) {
      return UserModel(name: name ?? '', email: email ?? '');
    }
    return null;
  }

  // Theme Preference (Dark Mode / Light Mode)
  static Future<void> setDarkMode(bool isDark) async {
    await prefs.setBool('is_dark_mode', isDark);
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static bool isDarkMode() {
    return prefs.getBool('is_dark_mode') ?? false;
  }

  // Logout
  static Future<void> logout() async {
    await prefs.remove('token');
    await prefs.remove('user_data');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }

  static bool get isLogin {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}
