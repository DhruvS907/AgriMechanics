import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController contact_numbercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  saveDetails(String Name, String Contact_Number, String Password,
      String Address) async {
    if (Name == "" && Contact_Number == "" && Password == "" && Address == "") {
      return UiHelper.CustomAlertBox(context, "Please Enter all the details");
    } else if (Contact_Number.length != 10) {
      return UiHelper.CustomAlertBox(
          context, "Please Enter a valid Mobile Number");
    } else {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(Contact_Number)
          .set({
        "Name": Name,
        "Contact Number": Contact_Number,
        "Password": Password,
        "Address": Address
      }).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Screen1(
                      UserName: Name,
                      Contact_Number: Contact_Number,
                    )));
      });
    }
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Please provide us with some of your\n details to proceed with",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: kLightPrimaryBackgroundColor),
                      ),
                      CustomTextField(namecontroller, "Name",
                          Icon(Icons.person), false, context, null),
                      CustomTextField(
                          contact_numbercontroller,
                          "Contact Number",
                          Icon(Icons.phone),
                          false,
                          context,
                          null),
                      CustomTextField(passwordcontroller, "Password",
                          Icon(Icons.password), true, context, null),
                      CustomTextField(addresscontroller, "Address",
                          Icon(Icons.place), false, context, null),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() {
                        saveDetails(
                            namecontroller.text.toString(),
                            contact_numbercontroller.text.toString(),
                            passwordcontroller.text.toString(),
                            addresscontroller.text.toString());
                      }, "Save Your Data", context),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
