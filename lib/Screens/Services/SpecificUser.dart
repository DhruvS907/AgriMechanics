import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customerDetails extends StatefulWidget {
  late String Contact_Number;
  customerDetails({super.key, required this.Contact_Number});

  @override
  State<customerDetails> createState() => _customerDetailsState();
}

class _customerDetailsState extends State<customerDetails> {
  Logout() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(SplashScreenState.KeyisLoggedInService, false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          color: kLightSecondaryColor,
          child: SizedBox(
            height: size.height * 0.9,
            width: size.width,
            child: Stack(children: [
              Positioned.fill(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .where("Contact Number", isEqualTo: widget.Contact_Number)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Name",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Name"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "2",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text(
                                      "Contact Number",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Contact Number"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "3",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Village, District",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Village, District"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "4",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Area of Cultivation",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Area of Cultivation"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "5",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Owns A Tractor",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Owns Tractor"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "6",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Equipments owned",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Owned Equipment"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "7",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Equipment needed",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Equipment needed"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "8",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text(
                                        "Knowledge about Government Subsidy",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Knowledge about Government Subsidy"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "9",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Equipment on lease",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Equipment on lease"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                            color: kLightSecondaryColor),
                                      ),
                                    ),
                                    title: Text("Equipment to exchange",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["Equipment to exchange"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                ]);
                              });
                        } else {
                          return Center(
                            child: Text(
                              'No customers yet !',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: kLightPrimaryBackgroundColor),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text(
                            'Error Occured',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: kLightPrimaryBackgroundColor),
                          ),
                        );
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Center(
                        child: Text(
                          'Could not load !',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: kLightPrimaryBackgroundColor),
                        ),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: kLightPrimaryBackgroundColor,
                      ));
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
