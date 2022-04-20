import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/device/device_utils.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Create_event extends StatefulWidget {
  const Create_event({Key? key}) : super(key: key);

  @override
  State<Create_event> createState() => _Create_eventState();
}

class _Create_eventState extends State<Create_event> {
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

  final format = DateFormat("yyyy-MM-dd HH:mm");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventCategoryController = TextEditingController();
  TextEditingController _eventLocationController = TextEditingController();
  TextEditingController _eventDateAndTimeController = TextEditingController();
  TextEditingController _eventPlaceDescriptionController =
      TextEditingController();

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
          title: Text('Create Event'),
          centerTitle: true,
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
                        child: TextFormField(
                          autocorrect: true,
                          controller: _eventCategoryController,
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
                    child: TextFormField(
                      controller: _eventCategoryController,
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
                          controller: _eventLocationController,
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
                        onPressed: () =>
                            {Routes.navigateToScreen(context, Routes.map)},
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
                      width: DeviceUtils.getScaledWidth(context, 0.55),
                      height: DeviceUtils.getScaledHeight(context, 0.08),
                      child: DateTimeField(
                        controller: _eventDateAndTimeController,
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 0.31),
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
                                  TextStyle(color: Colors.white, fontSize: 12),
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
                    Align(
                      alignment: Alignment.center,
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
                              'Browse',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        onPressed: imagePickerOption,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Browse',
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

  @override
  void dispose() {
    _eventDateAndTimeController.dispose();
    _eventPlaceDescriptionController.dispose();
    _eventCategoryController.dispose();
    _eventLocationController.dispose();
    _eventNameController.dispose();
    super.dispose();
  }
}
