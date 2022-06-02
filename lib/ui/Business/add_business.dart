import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Business/AddBusinessRequestModel.dart';
import 'package:guilt_app/models/Business/AddBusinessResponseModel.dart';
import 'package:guilt_app/models/Business/BusinessPlaceLostModal.dart';
import 'package:guilt_app/models/Business/BusinessSpaceListModal.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types

class Add_business extends StatefulWidget {
  @override
  State<Add_business> createState() => _Add_businessState();
}

class _Add_businessState extends State<Add_business> {
  final PostStore _postStore = PostStore(getIt<Repository>());
  List<BusinessSpaces> spaceList = [];
  List<BusinessPlaces> placeList = [];
  File? pickedImage;
  BusinessSpaces? selectedSpace;
  BusinessPlaces? selectedPlace;
  Map<String, double> businessLocation = {"Latitude": 0, "Longitude": 0};
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _businessContactController = TextEditingController();
  TextEditingController _businessEmailController = TextEditingController();
  TextEditingController _businessPriceController = TextEditingController();
  TextEditingController _businessLocationController = TextEditingController();
  TextEditingController _businessDescriptionController =
      TextEditingController();
  List<File> pickedImageList = [];
  late LatLng addressLatLng;

  @override
  void initState() {
    super.initState();
  }

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
        pickedImageList = [...pickedImageList, tempImage];
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  deleteImage(img) {
    var indexOfImage = pickedImageList.indexOf(img);
    if (indexOfImage >= 0) {
      setState(() {
        pickedImageList.removeAt(indexOfImage);
      });
    }
  }

  addNewBusiness() {
    if (_businessNameController.value.text.trim() != '') {
      if (_businessLocationController.value.text.trim() != '') {
        if (_businessContactController.value.text.trim() != '') {
          if (_businessEmailController.value.text.trim() != '') {
            if (_businessDescriptionController.value.text.trim() != '') {
              if (pickedImageList.length > 0) {
                AddBusinessRequestModel reqData = AddBusinessRequestModel(
                    name: _businessNameController.value.text,
                    description: _businessDescriptionController.value.text,
                    location: _businessLocationController.value.text,
                    lat: addressLatLng.latitude.toString(),
                    long: addressLatLng.longitude.toString(),
                    files: pickedImageList,
                    email: _businessEmailController.value.text,
                    contact: _businessContactController.value.text);

                GlobalStoreHandler.userStore.addBusiness(reqData, (AddBusinessResponseModel response) {
                //  var response = AddBusinessResponseModel.fromJson(value);
                  if (response.success == true) {
                    GlobalMethods.showSuccessMessage(
                        context, response.message ?? 'Success', 'Add Business');
                    // Routes.navigateToScreenWithArgs(context, Routes.book_event_details, response.business?.id);
                  } else {
                    GlobalMethods.showErrorMessage(
                        context,
                        response.message ?? 'Something went wrong',
                        'Add Business');
                  }
                }, (error, stackTrace) {
                  print(error.toString());
                });
                // TODO : Call Add New Business
              } else {
                GlobalMethods.showErrorMessage(context,
                    'Please upload business image', 'Business Image Required');
              }
            } else {
              GlobalMethods.showErrorMessage(
                  context,
                  'Please enter valid business description',
                  'Business Description Required');
            }
          } else {
            GlobalMethods.showErrorMessage(context,
                'Please enter valid business email', 'Business Email Required');
          }
        } else {
          GlobalMethods.showErrorMessage(
              context,
              'Please enter valid business contact',
              'Business Contact Required');
        }
      } else {
        GlobalMethods.showErrorMessage(
            context,
            'Please enter valid business address',
            'Business Location Required');
      }
    } else {
      GlobalMethods.showErrorMessage(context,
          'Please enter valid business name', 'Business Name Required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
            ),
            onPressed: () {
              Routes.goBack(context);
            },
          ),
          title: Text('Add Business'),
          centerTitle: true,
          shadowColor: Colors.transparent,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios_outlined),
          //   onPressed: () {
          //     Routes.goBack(context);
          //   },
          // ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: Text('SAVE'),
              onPressed: () {
                addNewBusiness();
              },
            )
          ],
        ),
        body: CustomBodyWrapper(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  TextFormField(
                    controller: _businessNameController,
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
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Container(
                          width: DeviceUtils.getScaledWidth(context, 0.60),
                          child: TextFormField(
                            controller: _businessLocationController,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (_businessLocationController.value.text.trim() !=
                              '') {
                            GlobalMethods.askLocationPermissionsOnly(context,
                                () async {
                              Map<String, dynamic> result =
                                  await Navigator.of(context)
                                      .pushNamed(Routes.map, arguments: {
                                'address':
                                    _businessLocationController.value.text
                              }) as Map<String, dynamic>;
                              setState(() {
                                if (result != null) {
                                  addressLatLng = result['position'] as LatLng;
                                  _businessLocationController.text =
                                      result['address'];
                                }
                              });
                            });
                          } else {
                            GlobalMethods.showErrorMessage(context,
                                'Please Enter Address', 'Address Required');
                          }
                          //var result =  Routes.navigateToScreen(context, Routes.map);
                        },
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
                    height: 25,
                  ),
                  Text(
                    "Entre your business contact",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _businessContactController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Business Contact',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Entre your business Email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _businessEmailController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Business Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 10,
                    controller: _businessDescriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text(
                        "Describe your place",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
                  Wrap(
                      alignment: WrapAlignment.start,
                      children: pickedImageList
                          .map(
                            (image) => Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2),
                                  ),
                                  child: ClipRect(
                                    child: image != null
                                        ? Image.file(
                                            image!,
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
                                Positioned(
                                  left: 65,
                                  child: InkWell(
                                    onTap: () {
                                      deleteImage(image);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      radius: 12,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList()
                      //getImages()

                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
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
                ],
              ),
            ),
          ),
        ));
  }
}
