// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class companyques extends StatelessWidget {
  companyques({super.key, required this.ownTractorisYes});
  late bool ownTractorisYes;
  TextEditingController companycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget widget1 = Container();
    Widget widget2 = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        // CustomTextField2(companycontroller, "Company Name",
        //     Icon(Icons.agriculture), false, context, false)
        TextFormField(
          controller: companycontroller,
          decoration: const InputDecoration(
              icon: Icon(Icons.agriculture),
              hintText: 'Tractor Company Name',
              labelText: "Tractor Company Name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter Customer's Equipment";
            }
            return null;
          },
        ),
      ],
    );
    return ownTractorisYes ? widget2 : widget1;
  }
}
