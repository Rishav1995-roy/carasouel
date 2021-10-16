import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider = Provider<SharedPreferenceService>((ref) => throw UnimplementedError());

class SharedPreferenceService{
  SharedPreferenceService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const userLoggedIn = 'userLoggedIn';
  static const userMarkfavorite = 'userMarkfavorite';

  Future<void> setUserLoginStatus(bool status) async {
    await sharedPreferences.setBool(userLoggedIn, status);
  }

  bool isUserLoggedIn() =>
      sharedPreferences.getBool(userLoggedIn) ?? false;


  Future<void> setFavoriteData(Map<String, dynamic> user) async{
    await sharedPreferences.setString(userMarkfavorite, jsonEncode(user));
  }

  Map<String,dynamic> getUserFavoriteData() =>
      jsonDecode(sharedPreferences.getString(userMarkfavorite)!) as Map<String, dynamic>;



}