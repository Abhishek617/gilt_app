import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

import 'dart:io';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/device/device_utils.dart';

class Create_event extends StatefulWidget {
  const Create_event({Key? key}) : super(key: key);

  @override
  State<Create_event> createState() => _Create_eventState();
}

class _Create_eventState extends State<Create_event> {
  final imagePicker = ImagePicker();
  File? imageFile;

  Future getImage() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      imageFile = File(image!.path);
    });
  }

  String dropdownvalue = 'Item 1';
  String? valueChange;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        isMenu: false,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              //color: Colors.black,
              size: 16,
            ),
          ),
          title: Text('            Create Event'),
          shadowColor: Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Event Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        width: DeviceUtils.getScaledWidth(context, 0.85),
                        height: DeviceUtils.getScaledHeight(context, 0.08),
                        child: TextField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            hintText: 'Enter Event Name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Enter Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                    width: DeviceUtils.getScaledWidth(context, 0.85),
                    height: DeviceUtils.getScaledHeight(context, 0.08),
                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Category',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        width: DeviceUtils.getScaledWidth(context, 0.54),
                        height: DeviceUtils.getScaledHeight(context, 0.06),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Enter Location'),
                        )),
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.32),
                      height: DeviceUtils.getScaledHeight(context, 0.05),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 13,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'Set on Map',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        onPressed: () =>{  Routes.navigateToScreen(context, Routes.map)},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1, // Thickness
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Date & Time or time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        width: DeviceUtils.getScaledWidth(context, 0.54),
                        height: DeviceUtils.getScaledHeight(context, 0.06),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Select date or time'),
                        )),
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.32),
                      height: DeviceUtils.getScaledHeight(context, 0.05),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 13,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'Date Picker',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1, // Thickness
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Describe your place",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.86),
                      child: TextFormField(
                        minLines: 2,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Enter your description',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Upload Business Photo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.20),
                      height: DeviceUtils.getScaledHeight(context, 0.10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.32),
                      height: DeviceUtils.getScaledHeight(context, 0.05),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 13,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Browser',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        onPressed: () {
                          getImage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Invite Attended",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Add Attendence with control list",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.30),
                      height: DeviceUtils.getScaledHeight(context, 0.04),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_note_sharp,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Browser',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: DeviceUtils.getScaledWidth(context, 0.35),
                        height: DeviceUtils.getScaledHeight(context, 0.04),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 13,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Contect',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Continue',
                      buttonColor: AppColors.primaryColor,
                      onPressed: () {
                        Routes.navigateToScreen(context, Routes.expense_screen);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
