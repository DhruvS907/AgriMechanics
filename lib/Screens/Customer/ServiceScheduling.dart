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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Schedule Services",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  )
                ],
              ),
            ),
            Card(
              color: kLightSecondaryColor,
              child: SizedBox(
                height: size.height * 0.82,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image(
                        image: AssetImage("assets/images/Logo1.png"),
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Fill the following details to Schedule your service",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                            "Date Choosen: ",
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
                          Container(
                            height: 50,
                            width: 113,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${_dateTime}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: kprimaryTextColor,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  _showDatePicker();
                                },
                                icon: Icon(Icons.date_range)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(nameofplacecontroller, "Name of Place",
                        Icon(Icons.agriculture), false, context),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(() async {
                      await scheduleServices(
                          _dateTime, nameofplacecontroller.text.toString());
                      UiHelper.CustomAlertBox(
                          context, "Your Service Has been scheduled");
                    }, "Confirm", context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
