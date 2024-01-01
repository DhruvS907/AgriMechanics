import 'package:agri_mechanic/Authentication_pages/Customer/OTPscreen.dart';

import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  UiHelper _uiHelper = UiHelper();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool enterPassword = true;
  ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    // Text("Enter phone number",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .headlineMedium!
                    //         .copyWith(
                    //             color: kLightPrimaryBackgroundColor,
                    //             fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Kindly enter your phone number",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kLightPrimaryBackgroundColor)),
                    CustomTextField(phoneController, 'Enter phone number',
                        Icon(Icons.call), false, context, true),
                    Visibility(
                      visible: enterPassword,
                      child: ValueListenableBuilder(
                          valueListenable: isHidden,
                          builder: (context, value, _) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: TextField(
                                controller: passwordController,
                                obscureText: value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: kprimaryTextColor,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 0),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: kLightSecondaryTextColor),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        isHidden.value = !isHidden.value;
                                      },
                                      icon: value
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                  suffixIconColor: kLightSecondaryTextColor,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                          color: kLightPrimaryBackgroundColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                          color: kLightSecondaryTextColor)),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(() async {
                      if (enterPassword) {
                        try {
                          DocumentSnapshot documentSnapshot =
                              await FirebaseFirestore.instance
                                  .collection('Customer')
                                  .doc(phoneController.text)
                                  .get();
                          if (documentSnapshot.exists) {
                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            sp.setBool(
                                splashScreenState.KeyisLoggedInpassword, true);
                            sp.setString(
                                splashScreenState.KeyisUsername, data['Name']);
                            sp.setString(splashScreenState.KeyisContact_Number,
                                phoneController.text);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return Screen1(
                                  UserName: data['Name'],
                                  Contact_Number: phoneController.text);
                            }));
                            phoneController.text = '';
                            passwordController.text = '';
                          } else {
                            UiHelper.CustomAlertBox(context,
                                'Contact number or password is not correct');
                          }
                          phoneController.text = '';
                          passwordController.text = '';
                        } catch (error) {
                          UiHelper.CustomAlertBox(context, error.toString());
                        }
                      } else {
                        FirebaseAuth.instance.verifyPhoneNumber(
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException ex) {
                              UiHelper.CustomAlertBox(
                                  context, "${ex.code.toString()}");
                            },
                            codeSent:
                                (String verificationId, int? resendtoken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OTPScreen(
                                            verificationId: verificationId,
                                            contactNumber:
                                                phoneController.text.toString(),
                                          )));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                            phoneNumber:
                                "+91" + phoneController.text.toString());
                      }
                    }, enterPassword ? 'Login' : 'Send OTP', context),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          enterPassword
                              ? "Sign in using OTP ?"
                              : "Sign in using password ?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: kLightSecondaryTextColor),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              enterPassword = !enterPassword;
                            });
                          },
                          child: Text(
                            enterPassword ? "Get OTP" : "Enter Password",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: kLightPrimaryBackgroundColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        kLightPrimaryBackgroundColor,
                                    decorationThickness: 1),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
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
        