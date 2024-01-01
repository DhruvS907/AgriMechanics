import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/Screens/Customer/details.dart';
import 'package:agri_mechanic/Screens/SaveData.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Enter 6 Digit OTP Sent to your number",
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpcontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
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
                        Map<String, dynamic> data =
                            documentSnapshot.data() as Map<String, dynamic>;
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setBool(
                            SplashScreenState.KeyisLoggedInpassword, true);
                        sp.setString(
                            SplashScreenState.KeyisUsername, data['Name']);
                        sp.setString(SplashScreenState.KeyisContact_Number,
                            widget.contactNumber);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return Screen1(
                              UserName: data['Name'],
                              Contact_Number: widget.contactNumber);
                        }));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => details(
                                      Contact_Number: widget.contactNumber,
                                    )));
                      }
                    } catch (error) {
                      UiHelper.CustomAlertBox(context, error.toString());
                    }
                  });
                } catch (ex) {
                  UiHelper.CustomAlertBox(context, ex.toString());
                }
              },
              child: Text("Verify"))
        ]),
      ),
    );
  }
}
