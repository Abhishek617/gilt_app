import 'dart:convert';
import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';

import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/device/device_utils.dart';

class Create_event extends StatefulWidget {
  final List<AppContact> Selectedcontactlist;

  const Create_event({Key? key, required this.Selectedcontactlist})
      : super(key: key);

  @override
  State<Create_event> createState() => _Create_eventState(Selectedcontactlist);
}

class _Create_eventState extends State<Create_event> {
  List<AppContact> Selectedcontactlist;

  _Create_eventState(this.Selectedcontactlist);

  File? pickedImage;
  final UserStore _userStore = UserStore(getIt<Repository>());

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
  TextEditingController _eventDateAndTimeController =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController _eventPlaceDescriptionController =
      TextEditingController();

  Widget getConditionsWidgets() {
    if (Selectedcontactlist!.length > 0) {
      return Row(
        children: Selectedcontactlist.map(
            (item) => Selectedcontactlist.indexOf(item) < 5
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 40,
                    width: 40,
                    // margin: EdgeInsets.all(100.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://img.icons8.com/color/344/person-male.png'),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.orange,
                        shape: BoxShape.circle),
                  )
                : Selectedcontactlist.lastIndexOf(item) == 5
                    ? Container(
              height: 40,
              width: 40,
              child: Padding(
                padding: EdgeInsets.only(top: 11),
                child: Text('+'+
                    (Selectedcontactlist.length - Selectedcontactlist.lastIndexOf(item)).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle),

            ):Container()



        ).toList(),
        
      );
    } else {
      return IconButton(icon: Icon(Icons.add), onPressed: () {});
    }
  }

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
                          controller: _eventNameController,
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
                      "Date & Time",
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
                        width: DeviceUtils.getScaledWidth(context, 0.85),
                        child: DateTimePicker(
                          controller: _eventDateAndTimeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(0)),
                          type: DateTimePickerType.dateTime,
                          dateMask: 'd MMM, yyyy HH:mm',
                          //initialValue: DateTime.now().toString(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          selectableDayPredicate: (date) {
                            // Disable weekend days to select from the calendar
                            if (date.weekday == 6 || date.weekday == 7) {
                              return false;
                            }

                            return true;
                          },
                          onChanged: (val) => print(val),
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        )),
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
                        controller: _eventPlaceDescriptionController,
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
                      children: <Widget>[
                        Text(
                          "Invite Attended",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Selectedcontactlist!.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  getConditionsWidgets(),
                                ],
                              )
                            : Text(
                                "Add Attendence with control list",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )
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
                          onPressed: () {
                            GlobalMethods.askPermissions(
                                context, Routes.add_contacts);
                          },
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
                        String eData = jsonEncode({
                          "name": _eventNameController.value.text,
                          "category": _eventCategoryController.value.text,
                          "location": _eventLocationController.value.text,
                          "startDate": _eventDateAndTimeController.value.text,
                          "description":
                              _eventPlaceDescriptionController.value.text
                        });
                        List<AppContact> Selectedcontactexpenselist = Selectedcontactlist;
                        Routes.navigateToScreenWithContactArgs(
                            context, Routes.expense_screen, eData, Selectedcontactexpenselist);
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
