import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class details extends StatefulWidget {
  late String Contact_Number;
  details({super.key, required this.Contact_Number});

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
                          Icon(Icons.person), false, context, false),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          controller: contact_numbercontroller,
                          readOnly: true,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: kprimaryTextColor,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 0),
                          decoration: InputDecoration(
                            hintText: widget.Contact_Number,
                            labelText: "Contact Number",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: kLightSecondaryTextColor),
                            suffixIcon: Icon(Icons.phone),
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
                      ),
                      CustomTextField(passwordcontroller, "Password",
                          Icon(Icons.password), true, context, null),
                      CustomTextField(addresscontroller, "Village, District",
                          Icon(Icons.place), false, context, null),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() async {
                        saveDetails(
                            namecontroller.text.toString(),
                            widget.Contact_Number,
                            passwordcontroller.text.toString(),
                            addresscontroller.text.toString());
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setString(SplashScreenState.KeyisUsername,
                            namecontroller.text.toString());
                        sp.setString(SplashScreenState.KeyisContact_Number,
                            widget.Contact_Number);
                      }, "Become a Member", context),
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
