// ignore_for_file: prefer_const_constructors

//import 'dart:js';
import 'dart:io';

import 'package:agri_mechanic/Authentication_pages/Customer/OTPscreen.dart';
import 'package:agri_mechanic/Authentication_pages/Customer/OtpAuthentication.dart';
import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/Screens/Customer/SeeyourServices.dart';
import 'package:agri_mechanic/Screens/Customer/SellyourImplement.dart';
import 'package:agri_mechanic/Screens/Customer/ServiceScheduling.dart';
import 'package:agri_mechanic/Screens/Customer/details.dart';
import 'package:agri_mechanic/Screens/Services/Form.dart';
import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/splashscreen.dart';

import 'package:agri_mechanic/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBkusTSCFwOGR4RH02xQKfaGUwYGODPztE',
              appId: '1:239415832507:android:ed86353a0bba923775de9e',
              messagingSenderId: '239415832507',
              projectId: 'agri-mechanic',
              storageBucket: 'gs://agri-mechanic.appspot.com'))
      : await Firebase.initializeApp();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kLightThemeData,
        home: splashScreen()),
  );
}
