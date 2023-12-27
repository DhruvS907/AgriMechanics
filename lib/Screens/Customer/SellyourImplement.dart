import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:agri_mechanic/uihelper.dart';
import 'package:agri_mechanic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellImplement extends StatefulWidget {
  const SellImplement({super.key});

  @override
  State<SellImplement> createState() => _SellImplementState();
}

class _SellImplementState extends State<SellImplement> {
  TextEditingController implementtosellcontroller = TextEditingController();
  TextEditingController desiredpricecontroller = TextEditingController();

  String imageUrl = '';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    "Sell your Implement",
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
                height: size.height * 0.82,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image(
                        image: AssetImage("assets/images/Logo1.png"),
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Fill the following details to Sell Your Implement",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        implementtosellcontroller,
                        "Name of the implement",
                        Icon(Icons.agriculture),
                        false,
                        context),
                    CustomTextField(
                        desiredpricecontroller,
                        "Enter the desired Price",
                        Icon(Icons.money),
                        false,
                        context),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(() async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      String uniqfilename =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqfilename);
                      try {
                        await referenceImageToUpload.putFile(File(file!.path));
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        UiHelper.CustomAlertBox(
                            context, "Error while uploading");
                      }
                    }, "Photograph of your Implement", context),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(() {}, "Confirm", context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
