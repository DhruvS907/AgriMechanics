import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(20),
      child: Stack(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where("Contact Number", isEqualTo: "8305070461")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.green, width: 0.5)),
                          child: ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(
                                "Name of Equipment: ${snapshot.data!.docs[index]["Owned Equipment"]}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                  "Date: ${snapshot.data!.docs[index]["Date"]}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                        );
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
      ]),
    ));
    ;
  }
}
