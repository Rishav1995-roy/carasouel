import 'package:carasouel/home_view.dart';
import 'package:carasouel/preference.dart';
import 'package:carasouel/user_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginWidget extends HookWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result != null) {
        Fluttertoast.showToast(
            msg: user?.displayName ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black38,
            textColor: Colors.white,
            fontSize: 16.0,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeWidget.routeName, (route) => false);
        final pref = context.read(sharedPreferencesServiceProvider);
        pref.sharedPreferences.clear();
        UserWidget.favoriteData.clear();
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'For simple login ',
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                textStyle: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeWidget.routeName, (route) => false);
                final pref = context.read(sharedPreferencesServiceProvider);
                pref.sharedPreferences.clear();
                UserWidget.favoriteData.clear();
              },
              child: Text('Click here!'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '------- or -------',
              style: GoogleFonts.lato(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'For social login ',
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                signup(context);
              },
              child: Image.asset(
                'assets/google.png',
                width: 30,
                height: 30,
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
