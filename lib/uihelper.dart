// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text,
      Icon icondata, bool tohide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
          controller: controller,
          obscureText: tohide,
          decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: text,
              suffixIcon: icondata,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)))),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
        width: 200,
        height: 75,
        child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.purple,
              fontSize: 20,
            ),
          ),
        ));
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          );
        });
  }
}
