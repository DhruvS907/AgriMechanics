import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});
  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController villagedistrictcontroller = TextEditingController();
  TextEditingController areaofcultivationcontroller = TextEditingController();
  TextEditingController tractorcontroller = TextEditingController();
  TextEditingController equipmentcontroller = TextEditingController();
  TextEditingController equipmentfuturecontroller = TextEditingController();
  TextEditingController govtsubsidycontroller = TextEditingController();
  TextEditingController leaseequipmentcontroller = TextEditingController();
  TextEditingController equipmentexchangecontroller = TextEditingController();

  SaveData(
      String Name,
      String Contact_Number,
      String place,
      String area_of_cultivation,
      String owns_tractor,
      String equipment_owned,
      String equipments_needed,
      String govt_sub,
      String equipment_lease,
      String equipment_exchange) async {
    if (Name == "" || Contact_Number == "" || place == "") {
      UiHelper.CustomAlertBox(context, "Enter Desired Fields");
    } else if (Contact_Number.length != 10) {
      return UiHelper.CustomAlertBox(
          context, "Please Enter a valid Mobile Number");
    } else {
      FirebaseFirestore.instance.collection("Users").doc(Name).set({
        "Name": Name,
        "Contact Number": Contact_Number,
        "Village, District": place,
        "Area of Cultivation": area_of_cultivation,
        "Owns Tractor": owns_tractor,
        "Owned Equipment": equipment_owned,
        "Equipment needed": equipments_needed,
        "Knowledge about Government Subsidy": govt_sub,
        "Equipment on lease": equipment_lease,
        "Equipment to exchange": equipment_exchange
      }).then((value) {
        UiHelper.CustomAlertBox(context, "Data Inserted");
      });
    }
  }

  Logout() {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Customer Details",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Logout();
                },
                icon: Icon(Icons.logout))
          ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Write your Name here',
                      labelText: 'Name *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return UiHelper.CustomAlertBox(
                          context, 'Please enter Name');
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mobilenumbercontroller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Write your Mobile Number here',
                      labelText: 'Contact Number *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return UiHelper.CustomAlertBox(
                          context, 'Please enter Contact Number');
                    } else if (value.length != 10) {
                      return UiHelper.CustomAlertBox(
                          context, 'Enter a valid mobile Number');
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: villagedistrictcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.home),
                      hintText: 'Write Customer Village, District Name here',
                      labelText: 'Village and District*'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return UiHelper.CustomAlertBox(context,
                          'Please enter Customer Village and District');
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: areaofcultivationcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.grass),
                      hintText: 'Write the Area of Cultivation here',
                      labelText: 'Area of Cultivation'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Area of Cultivation';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: tractorcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'Customer owns a tractor or not',
                      labelText: 'Owns a Tractor'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter if Customer owns a Tractor or not';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: equipmentcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'Equipments',
                      labelText: "Equipments owned"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Customer's Equipment";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: equipmentfuturecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'Equipments',
                      labelText: 'Equipments needed'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Customer's Equipment";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: govtsubsidycontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'Yes or No and if yes then what all subsidy',
                      labelText: "knowledge about government subsidy"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Customer's Response";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: leaseequipmentcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'Leased equiments',
                      labelText: "Customer's equipment taken on lease"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Customer's Response";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: equipmentexchangecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info),
                      hintText: 'equiments to be exchanged',
                      labelText: "Equipments to be exchanged"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Customer's Response";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                UiHelper.CustomButton(() {
                  SaveData(
                      namecontroller.text.toString(),
                      mobilenumbercontroller.text.toString(),
                      villagedistrictcontroller.text.toString(),
                      areaofcultivationcontroller.text.toString(),
                      tractorcontroller.text.toString(),
                      equipmentcontroller.text.toString(),
                      equipmentfuturecontroller.text.toString(),
                      govtsubsidycontroller.text.toString(),
                      leaseequipmentcontroller.text.toString(),
                      equipmentexchangecontroller.text.toString());
                }, "Save Data", context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
