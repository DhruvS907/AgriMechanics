import 'package:agri_mechanic/Screens/Services/imagedisplay.dart';
import 'package:agri_mechanic/utils/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class implementstosell extends StatefulWidget {
  const implementstosell({super.key});

  @override
  State<implementstosell> createState() => _implementstosellState();
}

class _implementstosellState extends State<implementstosell> {
  List imageList = ["imagePath1", "imagePath2"];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightSecondaryColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(2),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
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
                    height: size.height * 0.9,
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
                                if (snapshot.data!.docs.length > 0) {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Card(
                                              clipBehavior: Clip.hardEdge,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: SizedBox(
                                                height: 250,
                                                width: size.width * 0.95,
                                                child: Stack(children: [
                                                  imagedisplay(
                                                      imagePath1: snapshot
                                                              .data!.docs[index]
                                                          ["ImagePath1"],
                                                      imagePath2: snapshot
                                                              .data!.docs[index]
                                                          ["ImagePath2"]),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 22,
                                                          vertical: 6),
                                                      color: Colors.black54,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Name : ${snapshot.data!.docs[index]["Name"]}",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "Contact Number: ${snapshot.data!.docs[index]["Contact Number"]}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "Desired Price: ${snapshot.data!.docs[index]["Price"]}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ]),
                                                    ),
                                                  )
                                                ]),
                                              )),
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "No implements on sale yet !",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color:
                                                  kLightPrimaryBackgroundColor),
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                  child: Text(
                                    "${snapshot.hasError.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color:
                                                kLightPrimaryBackgroundColor),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kLightPrimaryBackgroundColor,
                                ),
                              );
                            }
                          }),
                    )),
              ],
            )),
      ),
    );
  }
}
