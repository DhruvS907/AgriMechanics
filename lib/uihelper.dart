// ignore_for_file: unused_import

import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  CustomTextField2(TextEditingController controller, String text, Icon icondata,
      bool tohide, BuildContext context, bool? isNumericKeyboard,
      {super.key})
      : context = context,
        text = text,
        icondata = icondata,
        tohide = tohide,
        controller = controller,
        isNumericKeyboard = isNumericKeyboard ?? false;

  TextEditingController controller;
  String text;
  Icon icondata;
  bool tohide;
  BuildContext context;
  bool isNumericKeyboard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: tohide,
        keyboardType: isNumericKeyboard ? TextInputType.number : null,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.black,
            decoration: TextDecoration.underline,
            decorationThickness: 0),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black),
          prefixIcon: icondata,
          prefixIconColor: Colors.black,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: kLightSecondaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: kLightSecondaryColor)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(TextEditingController controller, String text, Icon icondata,
      bool tohide, BuildContext context, bool? isNumericKeyboard,
      {super.key})
      : context = context,
        text = text,
        icondata = icondata,
        tohide = tohide,
        controller = controller,
        isNumericKeyboard = isNumericKeyboard ?? false;

  TextEditingController controller;
  String text;
  Icon icondata;
  bool tohide;
  BuildContext context;
  bool isNumericKeyboard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: tohide,
        keyboardType: isNumericKeyboard ? TextInputType.number : null,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: kprimaryTextColor,
            decoration: TextDecoration.underline,
            decorationThickness: 0),
        decoration: InputDecoration(
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
              borderSide: const BorderSide(color: kLightSecondaryTextColor)),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(VoidCallback voidCallback, String text, BuildContext context,
      {super.key})
      : voidCallback = voidCallback,
        text = text,
        context = context;
  VoidCallback voidCallback;
  String text;
  BuildContext context;
  @override
  Widget build(BuildContext context) {
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
}

class UiHelper {
  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Okay",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ))
            ],
          );
        });
  }
}
