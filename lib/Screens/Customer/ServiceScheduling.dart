import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
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

  String getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2023),
            lastDate: DateTime(2024),
            initialDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateTime = getFormattedDate(value!);
      });
    });
  }

  scheduleServices(String date, String placeName) async {
    if (date == "" && placeName == "") {
      return UiHelper.CustomAlertBox(context, "Please Enter all the details");
    } else {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(widget.Contact_Number)
          .update({"Date for Servicing": date, "Place": placeName}).then(
              (value) {
        UiHelper.CustomAlertBox(context, "Service Scheduled");
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
                        "Choose any one of our following \nservices :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: kLightPrimaryBackgroundColor),
                      ),
                      SizedBox(
                        height: 40,
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
                              onTap: () {
                                _showDatePicker();
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
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(nameofplacecontroller, "Name of Place",
                          Icon(Icons.agriculture), false, context, null),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(() async {
                        await scheduleServices(
                            _dateTime, nameofplacecontroller.text.toString());
                        UiHelper.CustomAlertBox(
                            context, "Your Service has been scheduled");
                      }, "Confirm", context)
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
