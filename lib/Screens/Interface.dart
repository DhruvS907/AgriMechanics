import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/Services/Userdata.dart';
import 'package:agri_mechanic/Screens/Services/implementstosell.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';

import 'package:agri_mechanic/utils/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainscreen2 extends StatefulWidget {
  const mainscreen2({super.key});

  @override
  State<mainscreen2> createState() => _mainscreen2State();
}

class _mainscreen2State extends State<mainscreen2>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  late AnimationController _controller;
  Logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(SplashScreenState.KeyisLoggedInService, false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InitialScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _offsetAnimation1 = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _offsetAnimation2 = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            child: SlideTransition(
              position: _offsetAnimation2,
              child: Image(
                image: const AssetImage("assets/images/Logo.png"),
                fit: BoxFit.cover,
                height: size.width,
                width: size.width,
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -5,
            right: -5,
            child: SlideTransition(
              position: _offsetAnimation1,
              child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(60))),
                  color: kLightSecondaryColor,
                  child: SizedBox(
                    height: size.height * 0.65,
                    width: size.width,
                    child: SingleChildScrollView(
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
                                  .copyWith(
                                      color: kLightPrimaryBackgroundColor,
                                      fontWeight: FontWeight.w700),
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
                                  .copyWith(
                                      color: kLightPrimaryBackgroundColor),
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
                              height: 20,
                            ),
                            CustomButton(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainScreen()));
                            }, "New Customer", context),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          implementstosell()));
                            }, "Implements to Sell", context),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(() {
                              Logout();
                            }, 'Logout', context),
                            SizedBox(
                              height: 60,
                            )
                          ]),
                    ),
                  )),
            ),
          ),
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