import 'package:agri_mechanic/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class implementstosell extends StatefulWidget {
  const implementstosell({super.key});

  @override
  State<implementstosell> createState() => _implementstosellState();
}

class _implementstosellState extends State<implementstosell> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kLightPrimaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Card(
                color: kLightSecondaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("Implements to Sell",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.all(16),
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
                                              title: SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  child: Image(
                                                    image: NetworkImage(snapshot
                                                            .data!.docs[index]
                                                        ["ImagePath"]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
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
