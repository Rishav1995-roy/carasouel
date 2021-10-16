import 'package:carasouel/home_view.dart';
import 'package:carasouel/login_view.dart';
import 'package:carasouel/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
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
