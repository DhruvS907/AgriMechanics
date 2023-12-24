import 'package:agri_mechanic/Authentication.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/main.dart';
import 'package:agri_mechanic/Screens/SaveData.dart';
import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: kLightPrimaryBackgroundColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(emailController, "Email",
                          Icon(Icons.mail), false, context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: ValueListenableBuilder(
                            valueListenable: isHidden,
                            builder: (context, value, _) {
                              return TextField(
                                controller: passwordController,
                                obscureText: isHidden.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: kprimaryTextColor,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 0),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: kLightSecondaryTextColor),
                                  suffixIcon: isHidden.value
                                      ? IconButton(
                                          icon:
                                              const Icon(Icons.visibility_off),
                                          onPressed: () {
                                            isHidden.value = false;
                                          },
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.visibility),
                                          onPressed: () {
                                            isHidden.value = true;
                                          },
                                        ),
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
                              );
                            }),
                      ),
                      CustomTextField(
                          confirmPasswordController,
                          "Confirm Password",
                          const Icon(Icons.password),
                          true,
                          context),
                      CustomButton(() async {
                        if (!(await checkPasswords(passwordController.text,
                            confirmPasswordController.text))) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Passwords do not match !',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: kLightPrimaryTextColor),
                            ),
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: kLightPrimaryBackgroundColor,
                          ));
                          return;
                        }
                        signUp(emailController.text.toString(),
                            passwordController.text.toString());
                      }, "Sign Up", context),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account already?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
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
                              "Login",
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
                          const SizedBox(
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
        ),
      ]),
    );
  }
}
