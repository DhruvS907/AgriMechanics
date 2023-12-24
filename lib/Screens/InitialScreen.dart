import 'package:agri_mechanic/Authentication_pages/Customer/OtpAuthentication.dart';
import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      // appBar: AppBar(
      //   title: AnimatedTextKit(
      //     animatedTexts: [
      //       TypewriterAnimatedText(
      //         'Welcome!!',
      //         textStyle: const TextStyle(
      //             fontSize: 32.0,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black),
      //         speed: const Duration(milliseconds: 500),
      //       ),
      //       TypewriterAnimatedText(
      //         'Agro Mechanics...',
      //         textStyle: const TextStyle(
      //             fontSize: 32.0,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.brown),
      //         speed: const Duration(milliseconds: 500),
      //       ),
      //     ],
      //     totalRepeatCount: 4,
      //     pause: const Duration(milliseconds: 1000),
      //     displayFullTextOnTap: true,
      //     stopPauseOnTap: true,
      //   ),
      //   centerTitle: true,
      // ),

      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image(
            image: const AssetImage("images/Logo.png"),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
            color: kLightSecondaryColor,
            child: SizedBox(
              height: size.height * 0.65,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }, "Services", context),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneAuth()));
                  }, "Customer", context)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
