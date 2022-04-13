import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guilt_app/models/Business/BusinessPlaceLostModal.dart';
import 'package:guilt_app/models/Business/BusinessSpaceListModal.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/rounded_button_widget.dart';

// ignore: camel_case_types

class Add_business extends StatefulWidget {
  @override
  State<Add_business> createState() => _Add_businessState();
}

class _Add_businessState extends State<Add_business> {
  File? pickedImage;
  BusinessSpaces? selectedSpace;
  BusinessPlaces? selectedPlace;
  List<BusinessSpaces> spaceList = [];
  List<BusinessPlaces> placeList = [];

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
        isMenu: false,
        isTab: false,
        appBar: AppBar(
          title: Text('Add Business'),
          centerTitle: true,
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Entre your business name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Business name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Choose your place will you host?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  // Initial Value
                  value: selectedPlace?.name ?? 'Select Option',
                  isExpanded: true,
                  hint: Text('Select option'),
                  style: TextStyle(fontSize: 13),
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: placeList.map((BusinessPlaces item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.name ?? item.id.toString()),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newData) {
                    setState(() {
                      selectedPlace = newData as BusinessPlaces?;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "What kind of space will guests have?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  // Initial Value
                  value: selectedSpace?.name ?? 'Select Option',
                  isExpanded: true,
                  hint: Text('Select option'),
                  style: TextStyle(fontSize: 13),
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: spaceList.map((BusinessSpaces item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.name ?? item.id.toString()),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newData) {
                    setState(() {
                      selectedSpace = newData as BusinessSpaces?;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text("Add Price",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.minimize,
                        size: 15,
                      ),
                    ),
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.30),
                      height: 30,
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                  ],
                ),
                Divider(
                  // color: Colors.teal.shade100,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                        width: DeviceUtils.getScaledWidth(context, 0.60),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Enter your address'),
                        )),
                    ElevatedButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12,
                          ),
                          Text(
                            ' Set on Map',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  // color: Colors.teal.shade100,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 2,
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label:  Text(
                      "Describe your place",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    ),
                    hintText: 'Enter your description',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Upload Business Photo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                              ),
                              child: ClipRect(
                                child: pickedImage != null
                                    ? Image.file(
                                  pickedImage!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 13),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Browse',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      onPressed: () {
                        imagePickerOption();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButtonWidget(
                    buttonText: 'Add Now',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.business_list);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
