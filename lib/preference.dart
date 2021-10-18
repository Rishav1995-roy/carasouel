import 'dart:convert';
import 'package:carasouel/userModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider = Provider<SharedPreferenceService>((ref) => throw UnimplementedError());

class SharedPreferenceService{
  SharedPreferenceService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  static const userMarkfavorite = 'userMarkfavorite';


  Future<void> setFavoriteData(List<Results> result) async{
    await sharedPreferences.setString(userMarkfavorite, jsonEncode(result));
  }

  List<Results> getUserFavoriteData() =>
      jsonDecode(sharedPreferences.getString(userMarkfavorite)!);



}