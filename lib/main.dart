// ignore_for_file: prefer_const_constructors

//import 'dart:js';
import 'dart:io';

import 'package:agri_mechanic/splashscreen.dart';

import 'package:agri_mechanic/utils/constants.dart';

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
        home: SplashScreen()),
  );
}
