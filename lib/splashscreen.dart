import 'package:agri_mechanic/Screens/Customer/Screen1.dart';

import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KeyisLoggedInService = 'Loginservices';
  static const String KeyisLoggedInpassword = 'Loginpassword';
  static const String KeyisUsername = 'Username';
  static const String KeyisContact_Number = 'Contact_Number';

  @override
  void initState() {
    super.initState();
    _navigator();
  }

  void _navigator() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLoggedInService = sp.getBool('Loginservices') ?? false;

    String UserName = sp.getString('Username') ?? '';
    String Contact_Number = sp.getString('Contact_Number') ?? '';

    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (isLoggedInService) {
                  return mainscreen2();
                } else {
                  return Screen1(
                      UserName: UserName, Contact_Number: Contact_Number);
                }
              }
              // else if (isLoggedInpassword) {
              //   return Screen1(
              //       UserName: UserName, Contact_Number: Contact_Number);
              // }
              else {
                return InitialScreen();
              }
            },
          ),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Text(
          //   "उपकरण सुधार \n खेतो में बहार",
          //   textAlign: TextAlign.center,
          //   style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          //       color: kLightPrimaryBackgroundColor,
          //       fontWeight: FontWeight.w700),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Hero(
            tag: 'assets/images/Logo.png',
            child: Image.asset(
              'assets/images/Logo.png',
              width: 400,
              height: 400,
            ),
          )
        ])),
      ),
    );
  }
}
