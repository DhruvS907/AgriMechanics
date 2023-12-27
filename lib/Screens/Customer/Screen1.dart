import 'package:agri_mechanic/Screens/Customer/SeeyourServices.dart';
import 'package:agri_mechanic/Screens/Customer/SellyourImplement.dart';
import 'package:agri_mechanic/Screens/Customer/ServiceScheduling.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  late String UserName;
  late String Contact_Number;
  Screen1({super.key, required this.UserName, required this.Contact_Number});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
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
                      CustomButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceScheduling(
                                      Contact_Number: widget.Contact_Number,
                                      Name: widget.UserName,
                                    )));
                      }, "Service Scheduling", context),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellImplement()));
                      }, "Sell Your Implement", context),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => seeyourservices(
                                    Contact_Number: widget.Contact_Number)));
                      }, "See your Services", context),
                      SizedBox(
                        height: 20,
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
