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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 45,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(80, 10, 80, 25),
                //   child: Container(
                //     height: 200,
                //     width: 200,
                //     child: Image(
                //       image: AssetImage("assets/images/Logo1.png"),
                //       fit: BoxFit.cover,
                //     ),
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //           color: const Color.fromARGB(255, 0, 113, 4), width: 4),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Card(
            color: kLightSecondaryColor,
            child: SizedBox(
              height: size.height * 0.745,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please Provide us some of your details",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "to proceed",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(namecontroller, "Name", Icon(Icons.person),
                        false, context),
                    CustomTextField(contact_numbercontroller, "Contact Number",
                        Icon(Icons.phone), false, context),
                    CustomTextField(passwordcontroller, "Password",
                        Icon(Icons.password), true, context),
                    CustomTextField(addresscontroller, "Address",
                        Icon(Icons.place), false, context),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(() {
                      saveDetails(
                          namecontroller.text.toString(),
                          contact_numbercontroller.text.toString(),
                          passwordcontroller.text.toString(),
                          addresscontroller.text.toString());
                    }, "Save Your Data", context)
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
