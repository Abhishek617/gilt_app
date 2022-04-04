import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../widgets/rounded_button_widget.dart';


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
              size: 10,
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
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Event Name",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                        width: 330,
                        height: 40,
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
                        )
                    ),

                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Enter Category",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
                    iconSize: 16,
                    isExpanded: true,
                    hint: Text('Slect your option'),
                    style: TextStyle(
                        fontSize: 13
                    ),
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Location",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 220,
                      height: 40,
                      child:TextFormField(
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Enter Location'),
                      )

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        height: 30,
                        width: 115,
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined , size: 13,),
                              SizedBox(
                                width: 2,
                              ),
                              Text('Set on Map',style: TextStyle(color: Colors.white, fontSize: 13),),
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
                  width: double.infinity,
                  height: 1, // Thickness
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Date & Time or time",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                        width: 220,
                        height: 40,
                        child:TextFormField(
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(

                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Select date or time'),
                        )

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        height: 30,
                        width: 115,
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined , size: 13,),
                              SizedBox(
                                width: 2,
                              ),
                              Text('Date Picker',style: TextStyle(color: Colors.white, fontSize: 13),),
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
                  width: double.infinity,
                  height: 1, // Thickness
                  color: Colors.grey,
                ),

                SizedBox(
                  height: 20,
                ),


                Row(
                  children: [
                    Text("Describe your place",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Container(
                      width: 320,
                      child: TextFormField(
                        minLines: 2,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Enter your description',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
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
                    Text("Upload Business Photo",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                        child: imageFile != null ? Image.file(imageFile!, fit: BoxFit.cover,) : Text('')
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 80,
                      width: 70,

                      decoration: BoxDecoration(

                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: imageFile != null ? Image.file(imageFile!,  fit: BoxFit.cover,) : Text(''),


                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: Container(
                   // height: 30,
                   // width: 105,
                    height: MediaQuery.of(context).size.height / 23.10,
                    width: MediaQuery.of(context).size.width / 3.6,
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 13,),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Browser',style: TextStyle(color: Colors.white, fontSize: 13),),
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
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Invite Attended",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 5,
                  width: 360,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: Container(
                        height: 30,
                        width: 110,
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(Icons.edit_note_sharp, size: 13, ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Browser',style: TextStyle(color: Colors.white, fontSize: 13),),
                            ],
                          ),
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 30,
                        width: 130,
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 13,),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Contect',style: TextStyle(color: Colors.white, fontSize: 13),),
                            ],
                          ),
                          onPressed: () {
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
                        Routes.navigateToScreen(
                            context, Routes.expense_screen);
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
