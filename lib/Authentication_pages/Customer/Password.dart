import 'package:agri_mechanic/Authentication_pages/Customer/OtpAuthentication.dart';
import 'package:agri_mechanic/Screens/Customer/details.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class passwordauthentication extends StatefulWidget {
  const passwordauthentication({super.key});

  @override
  State<passwordauthentication> createState() => _passwordauthenticationState();
}

class _passwordauthenticationState extends State<passwordauthentication> {
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
                  Text("Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: kLightPrimaryBackgroundColor,
                              fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Enter Correct Credentials to Proceed",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: kLightPrimaryBackgroundColor)),
                  CustomTextField(phonecontroller, 'Enter phone number',
                      Icon(Icons.call), false, context, true),
                  CustomTextField(passwordcontroller, 'Enter Password',
                      Icon(Icons.call), true, context, false),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(() {
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Customer")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.docs[index]
                                            ["Password"] ==
                                        passwordcontroller.text.toString()) {
                                      return details(
                                          Contact_Number:
                                              phonecontroller.text.toString());
                                    } else {
                                      return UiHelper.CustomAlertBox(
                                          context, "Enter Valid Details");
                                    }
                                  });
                            } else {
                              return Center(
                                child: Text("${snapshot.hasError.toString()}"),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  }, 'Sign In', context),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an account ?",
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
                                builder: (context) => PhoneAuth()),
                          );
                        },
                        child: Text(
                          "Sign Up using OTP verification",
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

class Authentication extends StatelessWidget {
  String Contact_Number;
  Authentication({super.key, required this.Contact_Number});

  @override
  Widget build(BuildContext context) {
    Widget widget1 =
        UiHelper.CustomAlertBox(context, "Enter Valid Credentials");
    Widget widget2 = details(Contact_Number: Contact_Number);
    return const Placeholder();
  }
}
