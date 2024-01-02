import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/Screens/Customer/details.dart';

import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  late String verificationId;
  late String contactNumber;

  OTPScreen(
      {super.key, required this.verificationId, required this.contactNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
            color: kLightSecondaryColor,
            child: SizedBox(
              height: size.height * 0.65,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text("Enter the 6 digit OTP sent to your phone number",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: kLightPrimaryBackgroundColor)),
                      CustomTextField(otpcontroller, 'Enter OTP',
                          Icon(Icons.phone), false, context, true),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() async {
                        if (await otpcontroller.text.length != 6) {
                          UiHelper.CustomAlertBox(
                              context, "OTP must have 6 digits!");
                          return;
                        }
                        try {
                          PhoneAuthCredential credential =
                              await PhoneAuthProvider.credential(
                                  verificationId: widget.verificationId,
                                  smsCode: otpcontroller.text.toString());

                          FirebaseAuth.instance
                              .signInWithCredential(credential)
                              .then((value) async {
                            try {
                              DocumentSnapshot documentSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('Customer')
                                      .doc(widget.contactNumber)
                                      .get();
                              if (documentSnapshot.exists) {
                                Map<String, dynamic> data = documentSnapshot
                                    .data() as Map<String, dynamic>;
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                sp.setBool(
                                    SplashScreenState.KeyisLoggedInpassword,
                                    true);
                                sp.setString(SplashScreenState.KeyisUsername,
                                    data['Name']);
                                sp.setString(
                                    SplashScreenState.KeyisContact_Number,
                                    widget.contactNumber);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Screen1(
                                          UserName: data['Name'],
                                          Contact_Number: widget.contactNumber);
                                    },
                                  ),
                                );
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => details(
                                              Contact_Number:
                                                  widget.contactNumber,
                                            )));
                              }
                            } catch (error) {
                              UiHelper.CustomAlertBox(
                                  context, error.toString());
                            }
                          }).onError((error, stackTrace) {
                            UiHelper.CustomAlertBox(context, 'Invalid OTP');
                          });
                        } catch (ex) {
                          UiHelper.CustomAlertBox(context, ex.toString());
                        }
                      }, 'Verify', context)
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
