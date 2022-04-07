import 'package:flutter/material.dart';
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
import '../../widgets/rounded_button_widget.dart';

class Add_contacts extends StatefulWidget {
  const Add_contacts({Key? key}) : super(key: key);

  @override
  State<Add_contacts> createState() => _Add_contactsState();

}

class _Add_contactsState extends State<Add_contacts> {

  static int _len = 10;
  List<bool> isChecked = List.generate(_len, (index) => false);

  bool checked = true;

  String _getTitle() =>
      "Checkbox : Checked = ${isChecked.where((check) => check == true).length}, "
          "Unchecked = ${isChecked.where((check) => check == false).length}";



  String _title = "Checkbox Demo";
  int selectedRadio = -1;

  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalMethods.askPermissions(context, Routes.atendees);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Attendees'),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      height: 45,
                      width: 45,
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(Icons.person_add_alt_1_rounded, size: 13),

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
                            hintText: 'Add New Contects'),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                  Text("Add Contect By User ID", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
          TextField(
            decoration: InputDecoration(
              hintText: "Search By User ID",
              suffixIcon: Icon(Icons.search),
            ),
          ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Contact List", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    height: 500,
                    // width: 460,
                    width: MediaQuery.of(context).size.width / 0.0,
                    child: ListView.builder(
                        itemCount: _len,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                              leading:  Container(
                                height: 40,
                                width: 40,
                                // margin: EdgeInsets.all(100.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('https://img.icons8.com/color/344/person-male.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.orange,
                                    shape: BoxShape.circle
                                ),
                              ),
                              trailing:
                              //Icon(Icons.radio_button_unchecked, size: 15,),
                             Container(
                               decoration: BoxDecoration(

                                 shape: BoxShape.circle,
                                 border: Border.all(
                                     color: Colors.black,
                                     width: 2.3),
                               ),
                               height: 20,
                               width: 20,
                               child: Checkbox(
                                 activeColor: Colors.white,
                                 checkColor: Colors.black,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.00))),

                                 onChanged: (changeValue){
                                   setState(() {
                                     if(changeValue == true){
                                       //checked[index] = true;
                                       checked = true;
                                       isChecked[index] = checked;
                                       _title = _getTitle();
                                     }else{
                                       isChecked[index] = false;

                                     }
                                     //isChecked[index] = checked;
                                     //_title = _getTitle();
                                   }
                                   );
                                 },
                                   value: isChecked[index],
                               ),
                             ),
                              title:Text("Abc $index")
                          );

                        }
                    ),

                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButtonWidget(
                        buttonText: 'Confirm',
                        buttonColor: AppColors.primaryColor,
                        onPressed: () {
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),

    );
  }
}

