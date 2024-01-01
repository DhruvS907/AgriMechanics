import 'package:agri_mechanic/Authentication_pages/Customer/OtpAuthentication.dart';

import 'package:agri_mechanic/Authentication_pages/Services/loginpage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  @override
  void initState() {
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
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _offsetAnimation2,
            child: Hero(
              tag: 'assets/images/Logo.png',
              child: Image(
                image: const AssetImage("assets/images/Logo.png"),
                fit: BoxFit.cover,
                height: size.width,
                width: size.width,
              ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Text("Welcome",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: kLightPrimaryBackgroundColor,
                                      fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 30,
                          ),
                          Text("How may we assist you today ?",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: kLightPrimaryBackgroundColor,
                                  )),
                          SizedBox(
                            height: 30,
                          ),
                          CustomButton(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }, "Services", context),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneAuth()));
                          }, "Customer", context),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "\"उपकरण सुधार  खेतो में बहार\"",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: kLightPrimaryBackgroundColor,
                                    ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
 
// TypewriterAnimatedText(
//                       'Transforming Agri-Tech Services:',
//                       textStyle: const TextStyle(
//                           fontSize: 25.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                       speed: const Duration(milliseconds: 200),
//                     ),
//                     TypewriterAnimatedText(
//                       'Mechanizing Rural Progress.',
//                       textStyle: const TextStyle(
//                           fontSize: 25.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                       speed: const Duration(milliseconds: 200),
//                     ),
