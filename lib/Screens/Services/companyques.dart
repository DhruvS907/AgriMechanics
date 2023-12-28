// ignore_for_file: camel_case_types

import 'package:agri_mechanic/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        CustomTextField(companycontroller, "Company Name",
            Icon(Icons.agriculture), false, context, false),
      ],
    );
    return ownTractorisYes ? widget2 : widget1;
  }
}
