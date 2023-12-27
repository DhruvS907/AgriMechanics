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
      body: Column(children: [
        Container(
          color: Colors.black,
          height: 200,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 45,
                ),
              ),
              Text(
                "${widget.UserName}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Card(
          color: kLightSecondaryColor,
          child: SizedBox(
            height: size.height * 0.74,
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
                  height: 20,
                ),
                Text(
                  "Choose any one of our following services: ",
                  style: TextStyle(fontSize: 15, color: Colors.white),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SellImplement()));
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
              ],
            ),
          ),
        )
      ]),
    );
  }
}
