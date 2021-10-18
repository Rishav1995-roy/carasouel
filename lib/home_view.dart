import 'package:carasouel/favorite_view.dart';
import 'package:carasouel/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeWidget extends HookWidget {
  static const routeName = "./home";

  final _pages = [
    UserWidget(),
    FavoriteWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationIndex = useState(0);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.white]),
        ),
        child: _pages[navigationIndex.value],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: navigationIndex.value,
        onTap: (int index)=> navigationIndex.value=index,
        selectedItemColor: Colors.lightBlue[50],
        backgroundColor: Colors.lightBlueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
