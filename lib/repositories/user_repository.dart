import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserRepository {
  static const String _userKey = 'current_user';
  
  // Mock user data for demonstration
  static const User _defaultUser = User(
    id: '1',
    name: 'Ahmed Saber',
    email: 'ahmed.saber@example.com',
    profileImageUrl: '',
    location: 'Cairo, Egypt',
  );

  Future<User> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson != null) {
        return User.fromJson(jsonDecode(userJson));
      } else {
        // Return default user and save it
        await updateUser(_defaultUser);
        return _defaultUser;
      }
    } catch (e) {
      return _defaultUser;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> saveUserPreferences({
    String? theme,
    String? language,
    bool? notifications,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (theme != null) {
        await prefs.setString('user_theme', theme);
      }
      if (language != null) {
        await prefs.setString('user_language', language);
      }
      if (notifications != null) {
        await prefs.setBool('user_notifications', notifications);
      }
    } catch (e) {
      throw Exception('Failed to save preferences: $e');
    }
  }

  Future<Map<String, dynamic>> getUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      return {
        'theme': prefs.getString('user_theme') ?? 'light',
        'language': prefs.getString('user_language') ?? 'en',
        'notifications': prefs.getBool('user_notifications') ?? true,
      };
    } catch (e) {
      return {
        'theme': 'light',
        'language': 'en',
        'notifications': true,
      };
    }
  }

  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove('user_theme');
      await prefs.remove('user_language');
      await prefs.remove('user_notifications');
    } catch (e) {
      throw Exception('Failed to clear user data: $e');
    }
  }

  Future<bool> isFirstTimeUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return !prefs.containsKey(_userKey);
    } catch (e) {
      return true;
    }
  }
}

