import 'package:carasouel/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'For simple login',
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

              },
              child: Image.asset(
                'assets/google.png',
                width: 60,
                height: 60,
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
