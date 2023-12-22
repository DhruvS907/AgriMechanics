import 'package:agri_mechanic/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();

  saveData(String FirstName, String LastName) async {
    if (FirstName == "" && LastName == "") {
      UiHelper.CustomAlertBox(context, "Enter Desired Fields");
    } else {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirstName)
          .set({"First Name": FirstName, "Last Name": LastName}).then((value) {
        UiHelper.CustomAlertBox(context, "Data Inserted");
      });
    }
  }

  UserCredential? userCredential;
  Logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add data"), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              Logout();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        UiHelper.CustomTextField(
            firstnamecontroller, "Your First Name", Icon(Icons.person), false),
        UiHelper.CustomTextField(
            lastnamecontroller, "Your Last Name", Icon(Icons.person), false),
        UiHelper.CustomButton(() {
          saveData(firstnamecontroller.text.toString(),
              lastnamecontroller.text.toString());
        }, "Save Data")
      ]),
    );
    ;
  }
}
