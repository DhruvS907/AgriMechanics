import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ServiceScheduling extends StatefulWidget {
  late String Name;
  late String Contact_Number;
  ServiceScheduling(
      {super.key, required this.Contact_Number, required this.Name});

  @override
  State<ServiceScheduling> createState() => _ServiceSchedulingState();
}

class _ServiceSchedulingState extends State<ServiceScheduling> {
  TextEditingController nameofplacecontroller = TextEditingController();
  TextEditingController nameofequipmentcontroller = TextEditingController();
  TextEditingController problemcontroller = TextEditingController();

  String getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<void> _showDatePicker() async {
    showDatePicker(
            context: context,
            firstDate: DateTime(2023),
            lastDate: DateTime(2024),
            initialDate: DateTime.now().subtract(Duration(days: 1)))
        .then((value) {
      setState(() {
        _dateTime = getFormattedDate(value!);
      });
    }).onError((error, stackTrace) {
      UiHelper.CustomAlertBox(context, '${error.toString()}');
    });
  }

  scheduleServices(String date, String placeName, String nameofimplement,
      String problemDescription) async {
    if (date == "" && placeName == "") {
      return UiHelper.CustomAlertBox(context, "Please Enter all the details");
    } else {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(widget.Contact_Number)
          .update({
        "Date for Servicing": date,
        "Place": placeName,
        "Name of Implement": nameofimplement,
        "Problem Description": problemDescription
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameofplacecontroller.dispose();
    nameofequipmentcontroller.dispose();
    problemcontroller.dispose();
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
                        height: 20,
                      ),
                      Text(
                        "Choose any one of our following \nservices :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: kLightPrimaryBackgroundColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Choose Date :",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: kprimaryTextColor,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                await _showDatePicker();
                              },
                              child: Container(
                                height: 50,
                                width: 113,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kLightPrimaryBackgroundColor,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    "${_dateTime}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: kprimaryTextColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(nameofplacecontroller, "Name of Place",
                          Icon(Icons.location_city), false, context, null),
                      CustomTextField(
                          nameofequipmentcontroller,
                          "Name of Equipment",
                          Icon(Icons.agriculture),
                          false,
                          context,
                          null),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          controller: problemcontroller,
                          keyboardType: TextInputType.multiline,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: kprimaryTextColor,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 0),
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: kLightSecondaryTextColor),
                            suffixIcon: Icon(Icons.description),
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
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() async {
                        await scheduleServices(
                            _dateTime,
                            nameofplacecontroller.text.toString(),
                            nameofequipmentcontroller.text.toString(),
                            problemcontroller.text.toString());
                        UiHelper.CustomAlertBox(
                            context, "Your Service has been scheduled");
                        Future.delayed(Duration(seconds: 2));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen1(
                                    UserName: widget.Name,
                                    Contact_Number: widget.Contact_Number)));
                      }, "Confirm", context),
                      SizedBox(
                        height: 60,
                      ),
                    ]),
              ),
            ),
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
                )))
      ]),
    );
  }
}
