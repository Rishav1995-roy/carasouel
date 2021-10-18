import 'dart:async';

import 'package:carasouel/preference.dart';
import 'package:carasouel/userModel.dart';
import 'package:carasouel/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';

class UserWidget extends HookWidget {
  late StreamSubscription _connectionChangeStream;
  static List<Results> favoriteData = [];
  @override
  Widget build(BuildContext context) {
    final isInitialLoad = useState(false);
    if (!isInitialLoad.value) {
      isInitialLoad.value = true;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        //EasyLoading.show(status: "Loading");
        context.read(viewModelProvider).getResults();
        //EasyLoading.dismiss();
      });
    }
    return ProviderListener(
      provider: viewModelProvider,
      onChange: (BuildContext context, state) {},
      child: UserView(),
    );
  }
}

class UserView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final results = useProvider(viewModelProvider).results;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return SwipeDetector(
              onSwipeRight: () {
                //EasyLoading.show(status: "Loading");
                print("swipe right");
                User user = new User(
                    gender: results[index].user.gender,
                    name: results[index].user.name,
                    location: results[index].user.location,
                    email: results[index].user.email,
                    username: results[index].user.username,
                    password: results[index].user.password,
                    salt: results[index].user.salt,
                    md5: results[index].user.md5,
                    sha1: results[index].user.sha1,
                    sha256: results[index].user.sha256,
                    registered: results[index].user.registered,
                    dob: results[index].user.dob,
                    phone: results[index].user.phone,
                    cell: results[index].user.cell,
                    ssl: results[index].user.ssl,
                    picture: results[index].user.picture,
                );
                Results data=new Results(user: user, seed: results[index].seed, version: results[index].version);
                UserWidget.favoriteData.add(data);
                final prefs = context.read(sharedPreferencesServiceProvider);
                prefs.setFavoriteData(UserWidget.favoriteData);
                Fluttertoast.showToast(
                    msg: "User added as favorite successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black38,
                    textColor: Colors.white,
                    fontSize: 16.0,
                );
                //EasyLoading.dismiss();
              },
              onSwipeLeft: () {
                print("swipe left");
                //EasyLoading.show(status: "Loading");
                context.read(viewModelProvider).getResults();
                //EasyLoading.dismiss();
              },
              child: Center(child: UserCardView(results[index])),
            );
          }),
    );
  }
}

class UserCardView extends HookWidget {
  Results results;

  UserCardView(this.results);

  @override
  Widget build(BuildContext context) {
    final cellState = useState(false);
    final dobState = useState(false);
    final addressState = useState(true);
    final phoneState = useState(false);
    final passwordState = useState(false);

    return Container(
      height: 500,
      margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(results.user.picture),
            ),
            Text(
              '${toBeginningOfSentenceCase(results.user.name.title)}. ${toBeginningOfSentenceCase(results.user.name.first)} ${toBeginningOfSentenceCase(results.user.name.last)}',
              style: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: Colors.black54,
              ),
            ),
            if (addressState.value) ...[
              UserTextWidget(
                text:
                    "${results.user.location.street}, ${results.user.location.city}, ${results.user.location.state} - ${results.user.location.zip}",
                heading: "My address is ",
              )
            ] else if (cellState.value) ...[
              UserTextWidget(
                text: results.user.cell,
                heading: 'My cell number is ',
              )
            ] else if (dobState.value) ...[
              UserTextWidget(
                text: formatTimestamp(int.parse(results.user.dob)),
                heading: 'My date of birth is ',
              )
            ] else if (passwordState.value) ...[
              UserTextWidget(
                text: results.user.password,
                heading: 'My password is ',
              )
            ] else if (phoneState.value) ...[
              UserTextWidget(
                text: results.user.phone,
                heading: 'My phone number is ',
              )
            ],
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      dobState.value = false;
                      addressState.value = false;
                      cellState.value = false;
                      passwordState.value = false;
                      cellState.value=!cellState.value;
                    },
                    child: Icon(
                      Icons.phone,
                      color: cellState.value ? Colors.green : Colors.grey,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cellState.value = false;
                      addressState.value = false;
                      phoneState.value = false;
                      passwordState.value = false;
                      dobState.value=!dobState.value;
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: dobState.value ? Colors.green : Colors.grey,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dobState.value = false;
                      cellState.value = false;
                      phoneState.value = false;
                      passwordState.value = false;
                      addressState.value=!addressState.value;
                    },
                    child: Icon(
                      Icons.location_on_outlined,
                      color: addressState.value ? Colors.green : Colors.grey,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dobState.value = false;
                      addressState.value = false;
                      cellState.value = false;
                      passwordState.value = false;
                      phoneState.value=!phoneState.value;
                    },
                    child: Icon(
                      Icons.phone,
                      color: phoneState.value ? Colors.green : Colors.grey,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dobState.value = false;
                      addressState.value = false;
                      phoneState.value = false;
                      cellState.value = false;
                      passwordState.value=!passwordState.value;
                    },
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: passwordState.value ? Colors.green : Colors.grey,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var formattedDate = DateFormat.yMMMd().format(date); // 'hh:mm' for hour & min
  return formattedDate;
}

class UserTextWidget extends HookWidget {
  final String text;
  final String heading;

  UserTextWidget({required this.text, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,),
      child: Column(
        children: [
          Text(
            heading,
            style: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
