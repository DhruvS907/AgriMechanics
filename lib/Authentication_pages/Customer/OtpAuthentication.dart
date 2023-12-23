import 'package:agri_mechanic/Authentication_pages/Customer/OTPscreen.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agri_mechanic/uihelper.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  UiHelper _uiHelper = UiHelper();
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
            color: kLightSecondaryColor,
            child: SizedBox(
              height: size.height * 0.65,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "We will send you a One time password on ",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: kLightPrimaryBackgroundColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                            controller: phonecontroller,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: kprimaryTextColor),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: 'Enter Phone Number',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: kLightSecondaryTextColor),
                                suffixIcon: Icon(Icons.phone),
                                focusColor: kLightPrimaryBackgroundColor,
                                // suffixIconColor: kLightSecondaryTextColor,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: kLightPrimaryBackgroundColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: kLightSecondaryTextColor)))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                            width: 250,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () async {
                                FirebaseAuth.instance.verifyPhoneNumber(
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException ex) {},
                                    codeSent: (String verificationId,
                                        int? resendtoken) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OTPScreen(
                                                    verificationId:
                                                        verificationId,
                                                  )));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                    phoneNumber: "+91" +
                                        phonecontroller.text.toString());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      kLightSecondaryBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: Text(
                                "Verify Phone Number",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: kLightPrimaryTextColor),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
