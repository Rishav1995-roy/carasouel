import 'package:carasouel/preference.dart';
import 'package:carasouel/userModel.dart';
import 'package:carasouel/user_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FavoriteWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = context.read(sharedPreferencesServiceProvider);
    //final favoriteData = prefs.getUserFavoriteData();
    final favoriteData = UserWidget.favoriteData;
    print("data $favoriteData");
    print(favoriteData.length);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: favoriteData.length == 0
          ? Center(
              child: Text(
                'No data found !',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteData.length,
              itemBuilder: (context, index) {
                return FavoriteCardView(favoriteData[index]);
              },
            ),
    );
  }
}

class FavoriteCardView extends HookWidget {
  final Results data;

  FavoriteCardView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(10.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(data.user.picture),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${toBeginningOfSentenceCase(data.user.name.title)}. ${toBeginningOfSentenceCase(data.user.name.first)} ${toBeginningOfSentenceCase(data.user.name.last)}',
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
