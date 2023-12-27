import 'package:agri_mechanic/Screens/Customer/showServices.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class seeyourservices extends StatefulWidget {
  late String Contact_Number;
  seeyourservices({super.key, required this.Contact_Number});

  @override
  State<seeyourservices> createState() => _seeyourservicesState();
}

class _seeyourservicesState extends State<seeyourservices> {
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
                        "Service History",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: kLightPrimaryBackgroundColor,
                                fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomButton(() {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ShowServices(
                              isPendingServices: true,
                              contactNumber: widget.Contact_Number);
                        }));
                      }, 'Pending Services', context),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ShowServices(
                              isPendingServices: false,
                              contactNumber: widget.Contact_Number);
                        }));
                      }, 'Completed Services', context),
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
