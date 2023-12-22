import 'package:agri_mechanic/Authentication.dart';
import 'package:agri_mechanic/Screens/Form.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/main.dart';
import 'package:agri_mechanic/Screens/SaveData.dart';
import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(225, 233, 128, 252),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        UiHelper.CustomTextField(
            emailController, "Email", Icon(Icons.mail), false),
        UiHelper.CustomTextField(
            passwordController, "Password", Icon(Icons.password), true),
        UiHelper.CustomButton(() async {
          signUp(emailController.text.toString(),
              passwordController.text.toString());
        }, "Sign Up"),
        SizedBox(
          height: 30,
        ),
      ]),
    );
  }
}
