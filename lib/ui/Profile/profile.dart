import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../widgets/rounded_button_with_icon.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? pickedImage;

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left:30.0,top:40.0,bottom:40.0,right:30.0),
            child: Text('please capture your image                 ..    \n\n..                                          .',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  backgroundColor: Colors.grey,
              ),
              ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 5),
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
          ),
                child: ClipOval(
                  child: pickedImage != null
                      ? Image.file(
                    pickedImage!,
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  )
                     : Image.network(
                      'https://th.bing.com/th/id/R.fa0ca630a6a3de8e33e03a009e406acd?rik=UOMXfynJ2FEiVw&riu=http%3a%2f%2fwww.clker.com%2fcliparts%2ff%2fa%2f0%2fc%2f1434020125875430376profile.png&ehk=73x7A%2fh2HgYZLT1q7b6vWMXl86IjYeDhub59EZ8hF14%3d&risl=&pid=ImgRaw&r=0',
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
      Padding(
        padding: EdgeInsets.all(15),
          child: Text('PROFILE PHOTO',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),
            textAlign: TextAlign.center,),
         ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left:30.0,top:170.0,bottom:20.0,right:30.0),
            child: ElevatedButtonWidgetWithIcon(
                buttonColor: Theme.of(context).colorScheme.primary,
                onPressed: imagePickerOption,
                icon: Icons.add_a_photo_sharp,
                buttonText:(
                    'Add Your Picture'
                )),
          )
        ],
      ),
    );
  }
}
