import 'package:agri_mechanic/Authentication_pages/Customer/OTPscreen.dart';
import 'package:agri_mechanic/Authentication_pages/Customer/Password.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text("Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: kLightPrimaryBackgroundColor,
                              fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 40,
                  ),
                  Text("We will send an OTP on",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: kLightPrimaryBackgroundColor)),
                  CustomTextField(phonecontroller, 'Enter phone number',
                      Icon(Icons.call), false, context, true),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(() async {
                    FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {
                          UiHelper.CustomAlertBox(
                              context, "${ex.code.toString()}");
                        },
                        codeSent: (String verificationId, int? resendtoken) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                        verificationId: verificationId,
                                        Contact_Number:
                                            phonecontroller.text.toString(),
                                      )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                        phoneNumber: "+91" + phonecontroller.text.toString());
                  }, 'Send OTP', context),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kLightSecondaryTextColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => passwordauthentication()),
                          );
                        },
                        child: Text(
                          "Sign In using Password",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: kLightPrimaryBackgroundColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kLightPrimaryBackgroundColor,
                                  decorationThickness: 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
  // Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           child: TextField(
  //             controller: phonecontroller,
  //             keyboardType: TextInputType.number,
  //             decoration: InputDecoration(
  //                 hintText: "Enter Phone Number",
  //                 suffixIcon: Icon(Icons.phone),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(25))),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         ElevatedButton(
  //             onPressed: () async {
  //               FirebaseAuth.instance.verifyPhoneNumber(
  //                   verificationCompleted: (PhoneAuthCredential credential) {},
  //                   verificationFailed: (FirebaseAuthException ex) {
  //                     UiHelper.CustomAlertBox(context, "${ex.code.toString()}");
  //                   },
  //                   codeSent: (String verificationId, int? resendtoken) {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => OTPScreen(
  //                                   verificationId: verificationId,
  //                                 )));
  //                   },
  //                   codeAutoRetrievalTimeout: (String verificationId) {},
  //                   phoneNumber: "+91" + phonecontroller.text.toString());
  //             },
  //             child: Text("Verify Phone Number"))
        