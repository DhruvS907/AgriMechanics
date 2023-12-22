import 'package:agri_mechanic/Authentication_pages/Customer/OtpAuthentication.dart';
import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/Screens/SaveData.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Welcome!!',
              textStyle: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              speed: const Duration(milliseconds: 500),
            ),
            TypewriterAnimatedText(
              'Agro Mechanics...',
              textStyle: const TextStyle(
                  fontSize: 32.0,
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
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image(image: AssetImage("images/Logo.png")),
                width: 500,
                height: 400,
              ),
            ),
            UiHelper.CustomButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }, "Services"),
            SizedBox(
              height: 20,
            ),
            UiHelper.CustomButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhoneAuth()));
            }, "Customer")
          ]),
    );
  }
}
