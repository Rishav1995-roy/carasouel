import 'package:carasouel/home_view.dart';
import 'package:carasouel/login_view.dart';
import 'package:carasouel/preference.dart';
import 'package:carasouel/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          SharedPreferenceService(sharedPreferences),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carasouel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginWidget(),
      routes: {
        HomeWidget.routeName: (ctx) => HomeWidget(),
      },
    );
  }
}
