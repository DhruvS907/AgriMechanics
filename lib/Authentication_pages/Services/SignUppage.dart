import 'package:agri_mechanic/Screens/Interface.dart';

import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);
  Future<bool> checkPasswords(String p1, String p2) async {
    if (p1 == p2) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  signUp(String email, String password) async {
    if (emailController.text == '' || passwordController.text == '') {
      UiHelper.CustomAlertBox(context, 'Please fill all the fields');
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => mainscreen2()));
        });
      } on FirebaseAuthException catch (ex) {
        UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
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
            child: Image(
              image: const AssetImage("assets/images/Logo.png"),
              fit: BoxFit.cover,
              height: size.width,
              width: size.width,
            ),
          ),
          Positioned(
              left: 16,
              top: 60,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ))),
          Positioned(
            bottom: -10,
            left: -5,
            right: -5,
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
                          Text("SignUp",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: kLightPrimaryBackgroundColor,
                                      fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextField(emailController, "Email",
                              Icon(Icons.mail), false, context, null),
                          ValueListenableBuilder(
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
                                            decoration:
                                                TextDecoration.underline,
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
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color:
                                                  kLightPrimaryBackgroundColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: kLightSecondaryTextColor)),
                                    ),
                                  ),
                                );
                              }),
                          CustomTextField(
                              confirmPasswordController,
                              "Confirm Password",
                              Icon(Icons.password),
                              true,
                              context,
                              null),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(() async {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return UiHelper.CustomAlertBox(
                                  context, 'Passwords do not match');
                            }
                            signUp(emailController.text.toString(),
                                passwordController.text.toString());
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            sp.setBool(
                                SplashScreenState.KeyisLoggedInService, true);
                          }, "SignUp", context),
                          SizedBox(
                            height: 10,
                          ),
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
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text(
                                  "LogIn",
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
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                )),
          ),
        ]));
  }
}
