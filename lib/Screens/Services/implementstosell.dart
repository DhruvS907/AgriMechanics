import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:agri_mechanic/Screens/Customer/details.dart';
import 'package:agri_mechanic/Screens/InitialScreen.dart';
import 'package:agri_mechanic/Screens/Interface.dart';
import 'package:agri_mechanic/Screens/Services/imagedisplay.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class implementstosell extends StatefulWidget {
  const implementstosell({super.key});

  @override
  State<implementstosell> createState() => _implementstosellState();
}

class _implementstosellState extends State<implementstosell> {
  List imageList = ["imagePath1", "imagePath2"];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(2),
            child: Card(
                color: kLightSecondaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mainscreen2()));
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Implements to Sell",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("ImplementsToSell")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                right: 10,
                                                left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: ListTile(
                                              onTap: () {},
                                              leading: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                      color:
                                                          kLightSecondaryColor),
                                                ),
                                              ),
                                              title: imagedisplay(
                                                  imagePath1:
                                                      snapshot.data!.docs[index]
                                                          ["ImagePath1"],
                                                  imagePath2:
                                                      snapshot.data!.docs[index]
                                                          ["ImagePath2"]),
                                              // Image(
                                              //   image: NetworkImage(
                                              //       snapshot.data!
                                              //               .docs[index]
                                              //           ["ImagePath1"]),
                                              //   fit: BoxFit.cover,
                                              // ))),
                                              // AnotherCarousel(
                                              //   images: [
                                              //     AssetImage(
                                              //         "assets/images/Logo.png"),
                                              //     AssetImage(
                                              //         "assets/images/Nature1.png"),
                                              //     NetworkImage(snapshot
                                              //             .data!
                                              //             .docs[index]
                                              //         ["ImagePath1"]),
                                              //   ],
                                              //   boxFit: BoxFit.cover,
                                              //   dotSize: 6,
                                              //   indicatorBgPadding: 5,
                                              // )
                                              // ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 20),
                                                child: Container(
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Name of Implement: ${snapshot.data!.docs[index]["Name"]}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  kLightSecondaryColor),
                                                        ),
                                                        Text(
                                                          "Contact Number: ${snapshot.data!.docs[index]["Contact Number"]}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  kLightSecondaryColor),
                                                        ),
                                                        Text(
                                                            "Desired Price: ${snapshot.data!.docs[index]["Price"]}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    kLightSecondaryColor))
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Text(
                                          "${snapshot.hasError.toString()}"),
                                    );
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        )),
                  ],
                ))),
      ),
    );
    ;
  }
}
