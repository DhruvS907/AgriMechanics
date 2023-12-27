import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/Services/Userdata.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../uihelper.dart';

class mainscreen2 extends StatefulWidget {
  const mainscreen2({super.key});

  @override
  State<mainscreen2> createState() => _mainscreen2State();
}

class _mainscreen2State extends State<mainscreen2> {
  Logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Welcome!!',
              textStyle: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              speed: const Duration(milliseconds: 500),
            ),
            TypewriterAnimatedText(
              'AGRIMechanics...',
              textStyle: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
              speed: const Duration(milliseconds: 500),
            ),
          ],
          totalRepeatCount: 4,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: AssetImage("assets/images/Logo.png")),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => customerData()));
            }, "Today's Customer", context),
            SizedBox(
              height: 20,
            ),
            CustomButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => mainScreen()));
            }, "New Customer", context)
          ]),
    );
  }
}
