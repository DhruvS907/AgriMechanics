import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/Services/Userdata.dart';
import 'package:agri_mechanic/Screens/Services/implementstosell.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../uihelper.dart';

class mainscreen2 extends StatefulWidget {
  const mainscreen2({super.key});

  @override
  State<mainscreen2> createState() => _mainscreen2State();
}

class _mainscreen2State extends State<mainscreen2> {
  Logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(splashScreenState.KeyisLoggedInService, false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InitialScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kLightPrimaryBackgroundColor,
        body: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image(
              image: const AssetImage("assets/images/Logo.png"),
              fit: BoxFit.cover,
              height: size.width,
              width: size.width,
            ),
          ),
          Positioned(
            bottom: -10,
            left: -5,
            right: -5,
            child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60))),
                color: kLightSecondaryColor,
                child: SizedBox(
                  height: size.height * 0.65,
                  width: size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Welcome",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: kLightPrimaryBackgroundColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Choose any one of our following \noptions :",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: kLightPrimaryBackgroundColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => customerData()));
                        }, "Today's Customer", context),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mainScreen()));
                        }, "New Customer", context),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => implementstosell()));
                        }, "Implements to Sell", context),
                      ]),
                )),
          ),
          Positioned(
              top: 30,
              right: 15,
              child: IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Logout();
                },
              ))
        ]));
  }
}
  // CustomButton(() {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => customerData()));
  //           }, "Today's Customer", context),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           CustomButton(() {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => mainScreen()));
  //           }, "New Customer", context)
  //         ]),