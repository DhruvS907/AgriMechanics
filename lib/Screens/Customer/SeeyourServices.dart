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
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Service History",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              )
            ],
          ),
        ),
        Card(
          color: kLightSecondaryColor,
          child: SizedBox(
            height: size.height * 0.80,
            width: size.width,
            child: Column(
              children: [
                Text("Pending Services",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Customer")
                        .where("Contact Number",
                            isEqualTo: widget.Contact_Number)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]["Date"] >
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 10,
                                          left: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: Colors.white, width: 0.5)),
                                      child: ListTile(
                                        onTap: () {},
                                        leading: CircleAvatar(
                                          child: Text("${index + 1}"),
                                        ),
                                        title: Text(
                                          "Name of Implement: ${snapshot.data!.docs[index]["Owned Equipment"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          "Date of Servicing: ${snapshot.data!.docs[index]["Date"]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ));
                                } else {
                                  return Container();
                                }
                              });
                        } else {
                          return Center(
                            child: Text("${snapshot.hasError.toString()}"),
                          );
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                Text("Completed Services",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where("Contact Number",
                            isEqualTo: widget.Contact_Number)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
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
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Colors.white, width: 0.5)),
                                    child: ListTile(
                                      onTap: () {},
                                      leading: CircleAvatar(
                                        child: Text("${index + 1}"),
                                      ),
                                      title: Text(
                                        "Name of Implement: ${snapshot.data!.docs[index]["Owned Equipment"]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "Date of Servicing: ${snapshot.data!.docs[index]["Date"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ));
                              });
                        } else {
                          return Center(
                            child: Text("${snapshot.hasError.toString()}"),
                          );
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
