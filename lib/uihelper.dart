// ignore_for_file: unused_import

import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text,
      Icon icondata, bool tohide, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
          controller: controller,
          obscureText: tohide,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: kprimaryTextColor),
          decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: text,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: kLightSecondaryTextColor),
              suffixIcon: icondata,
              suffixIconColor: kLightSecondaryTextColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: kLightPrimaryBackgroundColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: kLightSecondaryTextColor)))),
    );
  }

  static CustomButton(
      VoidCallback voidCallback, String text, BuildContext context) {
    return SizedBox(
        width: 250,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kLightSecondaryBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: kLightPrimaryTextColor),
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
