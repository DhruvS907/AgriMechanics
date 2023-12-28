import 'dart:io';
import 'dart:typed_data';
import 'package:agri_mechanic/Screens/Customer/Screen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellImplement extends StatefulWidget {
  String Name;
  String Contact_Number;
  SellImplement({super.key, required this.Name, required this.Contact_Number});

  @override
  State<SellImplement> createState() => _SellImplementState();
}

class _SellImplementState extends State<SellImplement> {
  TextEditingController nameController = TextEditingController();
  TextEditingController desiredpriceController = TextEditingController();
  XFile? file;
  String imageUrl = '';
  Reference? referenceImageToUpload;
  // pickImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile? _file = await _imagePicker.pickImage(source: source);
  //   if (_file != null) {
  //     return await _file.readAsBytes();
  //   } else {
  //     UiHelper.CustomAlertBox(context, "No image is selected");
  //   }
  // }

  // Uint8List? _image;

  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   _image = img;
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image(
            image: const AssetImage("assets/images/Logo.png"),
            fit: BoxFit.cover,
            height: size.width,
            width: size.width,
          ),
        ),
        Positioned(
          bottom: -10,
          left: -5,
          right: -5,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
            color: kLightSecondaryColor,
            child: SizedBox(
              height: size.height * 0.65,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          file = await imagePicker.pickImage(
                              source: ImageSource.camera);
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: kLightPrimaryDisabledTextColor,
                          backgroundImage: file == null
                              ? null
                              : FileImage(
                                  File(file!.path),
                                ),
                          child: file == null
                              ? Icon(
                                  Icons.image,
                                  color: kLightSecondaryTextColor,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Fill the following details to sell your implement :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: kLightPrimaryBackgroundColor),
                      ),
                      CustomTextField(nameController, "Name of the implement",
                          Icon(Icons.agriculture), false, context, null),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          controller: desiredpriceController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: kprimaryTextColor,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 0),
                          decoration: InputDecoration(
                            labelText: 'Enter desired Price',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: kLightSecondaryTextColor),
                            suffixIcon: Icon(Icons.monetization_on),
                            suffixIconColor: kLightSecondaryTextColor,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: kLightPrimaryBackgroundColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: kLightSecondaryTextColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(() async {
                        if (nameController.text == "" &&
                            desiredpriceController.text == "") {
                          return UiHelper.CustomAlertBox(
                              context, "Please enter all the details");
                        }
                        if (file == null)
                          return UiHelper.CustomAlertBox(
                              context, 'Please pick an image');
                        String uniqfilename =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        try {
                          referenceImageToUpload = FirebaseStorage.instance
                              .ref()
                              .child('images')
                              .child(uniqfilename);
                        } catch (error) {}
                        try {
                          await referenceImageToUpload!
                              .putFile(File(file!.path));

                          imageUrl =
                              await referenceImageToUpload!.getDownloadURL();
                        } catch (error) {
                          UiHelper.CustomAlertBox(
                              context, "Error while uploading");
                        }
                        try {
                          FirebaseFirestore.instance
                              .collection("ImplementsToSell")
                              .add({
                            "Name": nameController.text,
                            "Price": desiredpriceController.text,
                            "ImagePath": imageUrl,
                            "Contact Number": widget.Contact_Number
                          }).then((value) {
                            UiHelper.CustomAlertBox(
                                context, "Added to Database");
                            Future.delayed(Duration(seconds: 2));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen1(
                                        UserName: widget.Name,
                                        Contact_Number:
                                            widget.Contact_Number)));
                            setState(() {
                              file = null;
                              imageUrl = "";
                              nameController.text = "";
                              desiredpriceController.text = "";
                            });
                          }).onError((error, stackTrace) {});
                        } catch (error) {}
                      }, "Submit Details", context)
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
