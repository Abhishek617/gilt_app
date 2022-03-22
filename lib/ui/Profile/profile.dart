import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/rounded_button_with_icon.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/ui/Profile/full_profile.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Select a Photo",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  TextButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Text("Take Photo...",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  TextButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: Text("Choose from Library...",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  )
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
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          if (pickedImage != null)
            IconButton(
              padding: const EdgeInsets.only(
                  left: 00.0, top: 10.0, bottom: 5.0, right: 00.0),
              icon: Icon(Icons.check_sharp),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FullProfile()));
              },
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 30.0, top: 20.0, bottom: 40.0, right: 30.0),
            child: Center(
              child: Text(
                'Please add profile picture',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.primaryColour, width: 5),
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
            child: Text(
              'USER NAME',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, top: 100.0, bottom: 20.0, right: 30.0),
            child: ElevatedButtonWidgetWithIcon(
                buttonColor: AppColors.primaryColour,
                onPressed: imagePickerOption,
                icon: Icon(Icons.add_a_photo_sharp),
                buttonText: ('Add Your Picture')),
          )
        ],
      ),
    );
  }
}
