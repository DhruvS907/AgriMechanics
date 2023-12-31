import 'package:agri_mechanic/Screens/Customer/SellyourImplement.dart';
import 'package:agri_mechanic/Screens/Customer/ServiceScheduling.dart';
import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/splashscreen.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  late String UserName;
  late String Contact_Number;
  late String address;
  Screen1({
    super.key,
    required this.UserName,
    required this.Contact_Number,
  });

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  @override
  void initState() {
    print('Satik ${widget.Contact_Number}');
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _offsetAnimation1 = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _offsetAnimation2 = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: SlideTransition(
            position: _offsetAnimation2,
            child: Image(
              image: const AssetImage("assets/images/Logo.png"),
              fit: BoxFit.cover,
              height: size.width,
              width: size.width,
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -5,
          right: -5,
          child: SlideTransition(
            position: _offsetAnimation1,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(60))),
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
                          "Welcome ${widget.UserName[0].toUpperCase() + widget.UserName.substring(1)} !",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: kLightPrimaryBackgroundColor,
                                  fontWeight: FontWeight.w700),
                        ),
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
                                  builder: (context) => SellImplement(
                                        Name: widget.UserName,
                                        Contact_Number: widget.Contact_Number,
                                      )));
                        }, "Sell Your Implement", context),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(() async {
                          await FirebaseAuth.instance.signOut();
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          sp.setBool(
                              SplashScreenState.KeyisLoggedInpassword, false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InitialScreen()));
                        }, "Log Out", context),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
