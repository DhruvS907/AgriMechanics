import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/main.dart';
import 'package:agri_mechanic/Screens/SaveData.dart';
import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    if (email == "" || password == "") {
      UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
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
            bottom: -10,
            left: -5,
            right: -5,
            child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(60))),
                color: kLightSecondaryColor,
                child: SizedBox(
                  height: size.height * 0.65,
                  width: size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome,",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        CustomTextField(emailController, "Email",
                            Icon(Icons.mail), false, context),
                        CustomTextField(passwordController, "Password",
                            Icon(Icons.password), true, context),
                        CustomButton(() async {
                          signUp(emailController.text.toString(),
                              passwordController.text.toString());
                        }, "Sign Up", context),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                )),
          )
        ]));
  }
}
